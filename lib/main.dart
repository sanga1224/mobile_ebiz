import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/firebase_options.dart';
import 'package:mobile_ebiz/models/common_function.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/screens/main_screen.dart';
import 'package:mobile_ebiz/screens/splash_screen.dart';
import 'package:mobile_ebiz/services/api_login.dart';
import 'package:mobile_ebiz/themes/theme.dart';
import 'package:mobile_ebiz/themes/theme_provider.dart';
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
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

// 앱에서 지원하는 언어 리스트 변수
final supportedLocales = [const Locale('en', 'US'), const Locale('ko', 'KR')];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase 초기화
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // //알림 수신을 위한 권한 요청
  // if (await Permission.notification.isDenied) {
  //   await Permission.notification.request();
  // }
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // if (!kIsWeb) {
  //   await setupFlutterNotifications();
  // }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // In this example, suppose that all messages contain a data field with the key 'type'.
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    //탭했을 때 인식을 위한 리스너
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      debugPrint(message.data.toString());
      // Navigator.pushNamed(context, '/chat',
      //   arguments: ChatArguments(message),
      // );
    }
  }

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

  @override
  void initState() {
    super.initState();
    CommonFunction.setFcmToken(); //FCM token setting
    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    return const MainScreen(
      forceIndex: 2,
    );
  } else {
    return const SplashScreen();
  }
}
