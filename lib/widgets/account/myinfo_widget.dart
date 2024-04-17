import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/common_function.dart';
import 'package:mobile_ebiz/models/account/profile.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/popup/account/favorite_bl_widget.dart';
import 'package:mobile_ebiz/popup/account/favorite_schedule_widget.dart';
import 'package:mobile_ebiz/popup/account/profile_info.dart';
import 'package:mobile_ebiz/popup/account/recent_bl_widget.dart';
import 'package:mobile_ebiz/screens/main_screen.dart';
import 'package:mobile_ebiz/services/api_login.dart';
import 'package:mobile_ebiz/popup/account/alarm_widget.dart';
import 'package:mobile_ebiz/popup/notice/notice_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyInfoWidget extends StatefulWidget {
  const MyInfoWidget({super.key});

  @override
  State<MyInfoWidget> createState() => _MyInfoWidgetState();
}

class _MyInfoWidgetState extends State<MyInfoWidget> {
  Future<Profile> _profile = ApiLogIn.getProfile(0);

  @override
  Widget build(BuildContext context) {
    Future getUserInfo() async {
      setState(() {
        _profile = ApiLogIn.getProfile(0);
      });
    }

    void logout() {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.confirm,
          title: '',
          text: 'logout?'.tr(),
          confirmBtnText: 'yes'.tr(),
          cancelBtnText: 'no'.tr(),
          onConfirmBtnTap: () async {
            StatusMsg result = await ApiLogIn.logOut();
            if (!context.mounted) {
              return; //async-await gap 때문에 context가 null일 수 있어 추가 필요.
            }
            if (result.status == 'Y') {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('login_token', '');
              if (!context.mounted) {
                return; //async-await gap 때문에 context가 null일 수 있어 추가 필요.
              }
              CommonFunction.showSnackBar(
                  context, 'Logout_Completed'.tr(), true);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const MainScreen(
                    forceIndex: 2,
                  ),
                ),
              );
            }
          });
    }

    return FutureBuilder(
      future: _profile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileInfo(
                            initSeq: snapshot.data!.profile_seq,
                            func: getUserInfo,
                          ),
                          fullscreenDialog: true,
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.grey),
                              color: Theme.of(context).colorScheme.background,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              'assets/images/profiles/${snapshot.data!.icon.toString()}.svg',
                              width: 40,
                              height: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              snapshot.data!.nickname,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: getUserInfo,
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.outline,
                  thickness: 1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FavoriteScheduleWidget(),
                            fullscreenDialog: true,
                          ));
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.favorite_outline),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'myschedule'.tr(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoriteBLWidget(),
                            fullscreenDialog: true,
                          ));
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.favorite_outline),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'mybl'.tr(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RecentBLWidget(),
                            fullscreenDialog: true,
                          ));
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.history_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'recentbl'.tr(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      getUserInfo().then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AlarmWidget(),
                            fullscreenDialog: true,
                          ),
                        );
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.alarm_on_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'alarm_setting'.tr(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NoticeWidget(),
                            fullscreenDialog: true,
                          ));
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.speaker_notes_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'notice'.tr(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String nacd = prefs.getString('userNacd') ?? 'EN';
                      if (nacd == 'KR') {
                        launchUrl(
                            Uri.parse('http://sinokor.co.kr/kr/qnaList.html'));
                      } else {
                        launchUrl(
                            Uri.parse('http://sinokor.co.kr/en/net_02OS.html'));
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.headphones_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'csteam'.tr(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: GestureDetector(
                    onTap: logout,
                    child: Row(
                      children: [
                        const Icon(Icons.logout_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'logout'.tr(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).colorScheme.outline,
              size: 50,
            ),
          );
        }
      },
    );
  }
}
