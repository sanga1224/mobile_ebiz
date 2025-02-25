import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile_ebiz/firebase_options.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/screens/main_screen.dart';
import 'package:mobile_ebiz/screens/splash_screen.dart';
import 'package:mobile_ebiz/services/api_alarm.dart';
import 'package:mobile_ebiz/services/api_login.dart';
import 'package:mobile_ebiz/themes/theme.dart';
import 'package:mobile_ebiz/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await setupFlutterNotifications();
//   showFlutterNotification(message);
// }
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

// 앱에서 지원하는 언어 리스트 변수
final supportedLocales = [const Locale('en', 'US'), const Locale('ko', 'KR')];
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false; //셋팅여부 판단 flag

//셋팅 메소드
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', //id
    'High Importance Notifications', //title
    description:
        'This channel is used for important notifications.', //description
    importance: Importance.high,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  //iOS foreground notification 권한
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  //iOS background 권한 체킹, 요청
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  //토큰 요청
  getToken();
  //셋팅flag 설정
  isFlutterLocalNotificationsInitialized = true;
}

Future<void> getToken() async {
  //iOS
  String? token;
  // if (defaultTargetPlatform == TargetPlatform.iOS ||
  //     defaultTargetPlatform == TargetPlatform.macOS) {
  //   token = await FirebaseMessaging.instance.getAPNSToken();
  // } else {
  //AOS
  token = await FirebaseMessaging.instance.getToken();
  // }
  debugPrint('fcmToken : $token');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('fcmToken', token!);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase 초기화
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //Firebase setting
  await setupFlutterNotifications();

  // easylocalization 초기화!
  await EasyLocalization.ensureInitialized();
  //shared_preferences 초기화
  final prefs = await SharedPreferences.getInstance();
  //저장된 테마모드 가져오기
  final String? savedThemeMode = prefs.getString('themeMode');
  final ThemeData themeData;

  //기존 themeMode 설정을 안해놨을 경우(null) 시작 테마를 light로 지정
  //savedThemeMode가 null이 아닐 경우 저장된 테마모드에 따라 themeMode 설정
  if (savedThemeMode == null) {
    themeData = lightMode;
  } else if (savedThemeMode == "light") {
    themeData = lightMode;
  } else if (savedThemeMode == "dark") {
    themeData = darkMode;
  } else {
    themeData = darkMode;
  }

  runApp(
    EasyLocalization(
      // 지원 언어 리스트
      supportedLocales: supportedLocales,
      //path: 언어 파일 경로
      path: 'assets/translations',
      //fallbackLocale supportedLocales에 설정한 언어가 없는 경우 설정되는 언어
      fallbackLocale: const Locale('en', 'US'),

      //startLocale을 지정하면 초기 언어가 설정한 언어로 변경됨
      //만일 이 설정을 하지 않으면 OS 언어를 따라 기본 언어가 설정됨
      //startLocale: const Locale('ko', 'KR'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => ThemeProvider(initThemeData: themeData)),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

final ValueNotifier selectedIndexGlobal = ValueNotifier(2);
final ValueNotifier msgCountGlobal = ValueNotifier(0);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future chkLogIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? loginToken = prefs.getString('login_token');

    if (loginToken != null) {
      StatusMsg result = await ApiLogIn.chkLogIn();
      if (result.status == "Y") {
        return 'Completed';
      } else {
        prefs.setString('login_token', '');
        return 'Log-out';
      }
    } else {
      return '';
    }
  }

  void showFlutterNotification(RemoteMessage message) async {
    msgCountGlobal.value = await ApiAlarm.getCount();
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
          ),
        ),
      );
    }
  }

  void _handleMessage(RemoteMessage message) {
    selectedIndexGlobal.value = 4;
  }

  @override
  void initState() {
    super.initState();
    ApiAlarm.getCount().then((value) {
      msgCountGlobal.value = value;
    });
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 디버그 모드 배너 설정
      debugShowCheckedModeBanner: false,
      // 기본적으로 필요한 언어 설정
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Sinokor App',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3), chkLogIn),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: const Duration(microseconds: 1000),
            child: _splashLoadingWidget(snapshot),
          );
        },
      ),
    );
  }
}

Widget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
  if (snapshot.hasError) {
    return const Text('Error');
  } else if (snapshot.hasData) {
    return const MainScreen();
  } else {
    return const SplashScreen();
  }
}
