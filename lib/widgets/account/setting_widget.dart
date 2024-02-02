import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/profile.dart';
import 'package:mobile_ebiz/popup/account/profile_info.dart';
import 'package:mobile_ebiz/services/api_login.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({super.key});

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  Future<Profile> _profile = ApiLogIn.getProfile(0);

  @override
  Widget build(BuildContext context) {
    Future getUserInfo() async {
      setState(() {
        _profile = ApiLogIn.getProfile(0);
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
                            initSeq: snapshot.data!.seq,
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
                        onPressed: () {},
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
                  child: Row(
                    children: [
                      const Icon(Icons.plus_one_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'onetouchbk'.tr(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.my_library_add_outlined),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.settings_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'setting'.tr(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
