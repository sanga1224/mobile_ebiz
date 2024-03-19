import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/screens/account_screen.dart';
import 'package:mobile_ebiz/screens/alarm_screen.dart';
import 'package:mobile_ebiz/screens/list_screen.dart';
import 'package:mobile_ebiz/screens/schedule_screen.dart';
import 'package:mobile_ebiz/screens/search_screen.dart';
import 'package:mobile_ebiz/widgets/appbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.forceIndex});
  final int forceIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _widgetList = [
    const ScheduleScreen(pol: '', polnm: '', pod: '', podnm: '', yyyymm: ''),
    const ListScreen(
      bound: 'O',
      fmdt: '',
      todt: '',
      pol: '',
      pod: '',
    ),
    const SearchScreen(),
    const AccountScreen(
      returnPage: 'Main',
    ),
    const AlarmScreen(),
  ];
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.forceIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 3 ? null : const AppBarHome(),
      body: SafeArea(
        child: _widgetList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month_outlined),
            label: 'schedule'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_outlined),
            label: 'list'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search_outlined),
            label: 'search'.tr(),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'MY',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications_outlined),
            label: 'alarm'.tr(),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
