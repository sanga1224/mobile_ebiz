import 'package:flutter/material.dart';
import 'package:mobile_ebiz/screens/home_screen.dart';
import 'package:mobile_ebiz/screens/schedule_screen.dart';
import 'package:mobile_ebiz/themes/theme.dart';
import 'package:mobile_ebiz/themes/theme_provider.dart';
import 'package:mobile_ebiz/widgets/appbar_home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ThemeProvider(initThemeData: themeData)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> _widgetList = [
    const HomeScreen(),
    const ScheduleScreen(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: Scaffold(
        appBar: const AppBarHome(),
        body: SafeArea(
          child: _widgetList.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: '스케쥴',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              label: '검색',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_outlined),
              label: '리스트',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'MY',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
