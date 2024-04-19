import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/provider/msgcount_provider.dart';
import 'package:mobile_ebiz/screens/account_screen.dart';
import 'package:mobile_ebiz/screens/alarm_screen.dart';
import 'package:mobile_ebiz/screens/list_screen.dart';
import 'package:mobile_ebiz/screens/schedule_screen.dart';
import 'package:mobile_ebiz/screens/search_screen.dart';
import 'package:mobile_ebiz/widgets/appbar.dart';
import 'package:provider/provider.dart';

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
    // initFcmMsgCount();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Provider.of<MsgCountProvider>(context).addMsgCount();
      // print('Got a message whilst in the foreground!');
      // print('Message data: ${message.data}');

      // if (message.notification != null) {
      //   print('Message also contained a notification: ${message.notification}');
      // }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // void initFcmMsgCount() {
  //   ApiAlarm.getCount().then((value) {
  //     _msgCount = value;
  //   });
  // }

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
            icon: Stack(children: [
              const Icon(Icons.notifications_outlined),
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    maxWidth: 12,
                  ),
                  child: FutureBuilder(
                    future:
                        Provider.of<MsgCountProvider>(context).getMsgCount(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return const Text(
                          "0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        );
                      }
                    },
                  ),
                ),
              ),
            ]),
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
