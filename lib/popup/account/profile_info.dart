import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/account/profile.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/popup/account/profile_add.dart';
import 'package:mobile_ebiz/services/api_login.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key, required this.initSeq, required this.func});
  final int initSeq;
  final Function func;

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  int _seq = 0;

  @override
  Widget build(BuildContext context) {
    Future<List<Profile>>? profiles = ApiLogIn.getProfiles();

    _seq = _seq == 0 ? widget.initSeq : _seq;

    Future select() async {
      StatusMsg result = await ApiLogIn.setProfile(_seq);
      if (!context.mounted) {
        return result; //async-await gap 때문에 context가 null일 수 있어 추가 필요.
      }
      widget.func();
      Navigator.pop(context);
    }

    void setSeq(int seq) {
      if (seq == 0) {
        setState(() {
          _seq = 1;
        }); //추가한 프로필 Refresh로 보여주기 위함.
      } else {
        setState(() {
          profiles = ApiLogIn.getProfiles();
        });
        setState(() {
          _seq = seq;
        });
      }
    }

    void prev(int curSeq) {
      setState(() {
        _seq = curSeq - 1;
      });
    }

    void next(int curSeq) {
      setState(() {
        _seq = curSeq + 1;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'profile'.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileAdd(
                        seq: 0,
                        icon: 0,
                        nickName: '',
                        name: '',
                        cellno: '',
                        email: '',
                        telno: '',
                        faxno: '',
                        func: setSeq,
                      ),
                      fullscreenDialog: true,
                    ));
              },
              child: const Icon(
                Icons.person_add_outlined,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: profiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (_seq >= snapshot.data!.length) {
              _seq = snapshot.data!.length;
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        snapshot.data![_seq - 1].seq == 1
                            ? const Text('           ')
                            : GestureDetector(
                                onTap: () {
                                  prev(snapshot.data![_seq - 1].seq);
                                },
                                child: const Icon(
                                  Icons.chevron_left,
                                  size: 40,
                                ),
                              ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.grey),
                            color: Theme.of(context).colorScheme.background,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/images/profiles/${snapshot.data![_seq - 1].icon}.svg',
                            width: 150,
                            height: 150,
                          ),
                        ),
                        snapshot.data![_seq - 1].seq ==
                                snapshot.data![_seq - 1].maxseq
                            ? const Text('           ')
                            : GestureDetector(
                                onTap: () {
                                  next(snapshot.data![_seq - 1].seq);
                                },
                                child: const Icon(
                                  Icons.chevron_right,
                                  size: 40,
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "nickname".tr(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            snapshot.data![_seq - 1].nickname,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "name".tr(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            snapshot.data![_seq - 1].name,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "cellno".tr(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            snapshot.data![_seq - 1].cellno,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "email".tr(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            snapshot.data![_seq - 1].email,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "telno".tr(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            snapshot.data![_seq - 1].telno,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "faxno".tr(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            snapshot.data![_seq - 1].faxno,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileAdd(
                                    seq: snapshot
                                        .data![(_seq == 0
                                                ? widget.initSeq
                                                : _seq) -
                                            1]
                                        .seq,
                                    icon: snapshot
                                        .data![(_seq == 0
                                                ? widget.initSeq
                                                : _seq) -
                                            1]
                                        .icon,
                                    nickName: snapshot
                                        .data![(_seq == 0
                                                ? widget.initSeq
                                                : _seq) -
                                            1]
                                        .nickname,
                                    name: snapshot
                                        .data![(_seq == 0
                                                ? widget.initSeq
                                                : _seq) -
                                            1]
                                        .name,
                                    cellno: snapshot
                                        .data![(_seq == 0
                                                ? widget.initSeq
                                                : _seq) -
                                            1]
                                        .cellno,
                                    email: snapshot
                                        .data![(_seq == 0
                                                ? widget.initSeq
                                                : _seq) -
                                            1]
                                        .email,
                                    telno: snapshot
                                        .data![(_seq == 0
                                                ? widget.initSeq
                                                : _seq) -
                                            1]
                                        .telno,
                                    faxno: snapshot
                                        .data![(_seq == 0
                                                ? widget.initSeq
                                                : _seq) -
                                            1]
                                        .faxno,
                                    func: setSeq,
                                  ),
                                  fullscreenDialog: true,
                                ));
                          },
                          icon: const Icon(Icons.edit_note_outlined),
                          label: Text('revise'.tr()),
                          style: Theme.of(context).elevatedButtonTheme.style,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: select,
                          icon: const Icon(Icons.check_outlined),
                          label: Text('select'.tr()),
                          style: Theme.of(context).elevatedButtonTheme.style,
                        ),
                      ],
                    ),
                  ],
                ),
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
      ),
    );
  }
}
