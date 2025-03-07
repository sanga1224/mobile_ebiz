import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/main.dart';
import 'package:mobile_ebiz/screens/account_screen.dart';
import 'package:mobile_ebiz/screens/alarm_screen.dart';
import 'package:mobile_ebiz/screens/list_screen.dart';
import 'package:mobile_ebiz/screens/schedule_screen.dart';
import 'package:mobile_ebiz/screens/search_screen.dart';
import 'package:mobile_ebiz/widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.status});
  final String status;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String getStoreUrl() {
    if (Platform.isAndroid) {
      return "https://play.google.com/store/apps/details?id=com.sinokor.mobileEbiz&gl=US";
    } else if (Platform.isIOS) {
      return "https://apps.apple.com/kr/app/sinokor-m/id6502036160";
    } else {
      return "";
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.status == 'Update') {
        CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.confirm,
          title: 'Update',
          text: 'update?'.tr(),
          confirmBtnText: 'yes'.tr(),
          cancelBtnText: 'no'.tr(),
          onConfirmBtnTap: () {
            launchUrl(Uri.parse(getStoreUrl()),
                mode: LaunchMode.externalApplication);
          },
        );
      } else if (widget.status == "Force Update") {
        CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.info,
          title: 'Update',
          text: 'update!'.tr(),
          confirmBtnText: 'yes'.tr(),
          onConfirmBtnTap: () {
            launchUrl(Uri.parse(getStoreUrl()),
                mode: LaunchMode.externalApplication);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetList = [
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

    void onItemTapped(int index) {
      selectedIndexGlobal.value = index;
    }

    return ValueListenableBuilder(
        valueListenable: selectedIndexGlobal,
        builder: (context, val, child) {
          return Scaffold(
            appBar: selectedIndexGlobal.value == 3 ? null : const AppBarHome(),
            body: SafeArea(
              child: widgetList.elementAt(selectedIndexGlobal.value),
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
                        child: ValueListenableBuilder(
                          valueListenable: msgCountGlobal,
                          builder: (context, value, child) {
                            return Text(
                              msgCountGlobal.value.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
                  label: 'alarm'.tr(),
                ),
              ],
              currentIndex: selectedIndexGlobal.value,
              selectedItemColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              unselectedItemColor: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
              onTap: onItemTapped,
            ),
          );
        });
  }
}
