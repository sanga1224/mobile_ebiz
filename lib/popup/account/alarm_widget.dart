import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/account/profile.dart';
import 'package:mobile_ebiz/services/api_login.dart';

class AlarmWidget extends StatefulWidget {
  const AlarmWidget({super.key});

  @override
  State<AlarmWidget> createState() => _AlarmWidgetState();
}

class _AlarmWidgetState extends State<AlarmWidget> {
  Future<Profile>? _profile;

  Future search() async {
    setState(() {
      _profile = ApiLogIn.getProfile(0);
    });
  }

  bool _rcvBKCChecked = false;
  ValueNotifier<bool> _rcvBKCSwitch = ValueNotifier(false);
  bool _rcvBLCChecked = false;
  ValueNotifier<bool> _rcvBLCSwitch = ValueNotifier(false);
  bool _rcvCACChecked = false;
  ValueNotifier<bool> _rcvCACSwitch = ValueNotifier(false);
  bool _rcvBLIChecked = false;
  ValueNotifier<bool> _rcvBLISwitch = ValueNotifier(false);
  bool _rcvBLPChecked = false;
  ValueNotifier<bool> _rcvBLPSwitch = ValueNotifier(false);
  bool _rcvLCCChecked = false;
  ValueNotifier<bool> _rcvLCCSwitch = ValueNotifier(false);
  bool _rcvIVIChecked = false;
  ValueNotifier<bool> _rcvIVISwitch = ValueNotifier(false);
  bool _rcvTXIChecked = false;
  ValueNotifier<bool> _rcvTXISwitch = ValueNotifier(false);
  bool _rcvFTCChecked = false;
  ValueNotifier<bool> _rcvFTCSwitch = ValueNotifier(false);
  bool _rcvDGCChecked = false;
  ValueNotifier<bool> _rcvDGCSwitch = ValueNotifier(false);
  bool _rcvDLNChecked = false;
  ValueNotifier<bool> _rcvDLNSwitch = ValueNotifier(false);
  bool _rcvVSCChecked = false;
  ValueNotifier<bool> _rcvVSCSwitch = ValueNotifier(false);
  bool _rcvTSCChecked = false;
  ValueNotifier<bool> _rcvTSCSwitch = ValueNotifier(false);
  bool _rcvDOCChecked = false;
  ValueNotifier<bool> _rcvDOCSwitch = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    search();
  }

  @override
  Widget build(BuildContext context) {
    void setAlarm(String gb, String val) async {
      await ApiLogIn.updateAlarm(gb, val);
      search();
      // if (result.status == 'Y') {
      //   CommonFunction.showSnackBar(
      //       context, 'alarm_setting_completed'.tr(), true);
      // } else {
      //   if (mounted) {
      //     CommonFunction.showSnackBar(
      //         context, 'alarm_setting_failed'.tr(), false);
      //   }
      // }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'alarm_setting'.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _profile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _rcvBKCChecked = snapshot.data!.bkc == 'Y' ? true : false;
            _rcvBKCSwitch = ValueNotifier<bool>(_rcvBKCChecked);
            _rcvBLCChecked = snapshot.data!.blc == 'Y' ? true : false;
            _rcvBLCSwitch = ValueNotifier<bool>(_rcvBLCChecked);
            _rcvCACChecked = snapshot.data!.cac == 'Y' ? true : false;
            _rcvCACSwitch = ValueNotifier<bool>(_rcvCACChecked);
            _rcvBLIChecked = snapshot.data!.bli == 'Y' ? true : false;
            _rcvBLISwitch = ValueNotifier<bool>(_rcvBLIChecked);
            _rcvBLPChecked = snapshot.data!.blp == 'Y' ? true : false;
            _rcvBLPSwitch = ValueNotifier<bool>(_rcvBLPChecked);
            _rcvLCCChecked = snapshot.data!.lcc == 'Y' ? true : false;
            _rcvLCCSwitch = ValueNotifier<bool>(_rcvLCCChecked);
            _rcvIVIChecked = snapshot.data!.ivi == 'Y' ? true : false;
            _rcvIVISwitch = ValueNotifier<bool>(_rcvIVIChecked);
            _rcvTXIChecked = snapshot.data!.txi == 'Y' ? true : false;
            _rcvTXISwitch = ValueNotifier<bool>(_rcvTXIChecked);
            _rcvFTCChecked = snapshot.data!.ftc == 'Y' ? true : false;
            _rcvFTCSwitch = ValueNotifier<bool>(_rcvFTCChecked);
            _rcvDGCChecked = snapshot.data!.dgc == 'Y' ? true : false;
            _rcvDGCSwitch = ValueNotifier<bool>(_rcvDGCChecked);
            _rcvDLNChecked = snapshot.data!.dln == 'Y' ? true : false;
            _rcvDLNSwitch = ValueNotifier<bool>(_rcvDLNChecked);
            _rcvVSCChecked = snapshot.data!.vsc == 'Y' ? true : false;
            _rcvVSCSwitch = ValueNotifier<bool>(_rcvVSCChecked);
            _rcvTSCChecked = snapshot.data!.tsc == 'Y' ? true : false;
            _rcvTSCSwitch = ValueNotifier<bool>(_rcvTSCChecked);
            _rcvDOCChecked = snapshot.data!.doc == 'Y' ? true : false;
            _rcvDOCSwitch = ValueNotifier<bool>(_rcvDOCChecked);

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'alarm_bkc'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvBKCSwitch,
                          initialValue: _rcvBKCChecked,
                          onChanged: (value) {
                            setState(() {
                              if (_rcvBKCChecked) {
                                _rcvBKCChecked = false;
                              } else {
                                _rcvBKCChecked = true;
                              }
                              setAlarm('BKC', _rcvBKCChecked ? 'Y' : 'N');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'alarm_blc'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvBLCSwitch,
                          initialValue: _rcvBLCChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvBLCChecked = value;
                              setAlarm('BLC', _rcvBLCChecked ? 'Y' : 'N');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'alarm_cac'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvCACSwitch,
                          initialValue: _rcvCACChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvCACChecked = value;
                              setAlarm('CAC', _rcvCACChecked ? 'Y' : 'N');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'alarm_bli'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvBLISwitch,
                          initialValue: _rcvBLIChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvBLIChecked = value;
                              setAlarm('BLI', _rcvBLIChecked ? 'Y' : 'N');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'alarm_blp'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvBLPSwitch,
                          initialValue: _rcvBLPChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvBLPChecked = value;
                              setAlarm('BLP', _rcvBLPChecked ? 'Y' : 'N');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'alarm_lcc'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvLCCSwitch,
                          initialValue: _rcvLCCChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvLCCChecked = value;
                              setAlarm('LCC', _rcvLCCChecked ? 'Y' : 'N');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'alarm_ivi'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvIVISwitch,
                          initialValue: _rcvIVIChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvIVIChecked = value;
                              setAlarm('IVI', _rcvIVIChecked ? 'Y' : 'N');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'alarm_txi'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvTXISwitch,
                          initialValue: _rcvTXIChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvTXIChecked = value;
                              setAlarm('TXI', _rcvTXIChecked ? 'Y' : 'N');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'alarm_ftc'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvFTCSwitch,
                          initialValue: _rcvFTCChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvFTCChecked = value;
                              setAlarm('FTC', _rcvFTCChecked ? 'Y' : 'N');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'alarm_dgc'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvDGCSwitch,
                          initialValue: _rcvDGCChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvDGCChecked = value;
                              setAlarm('DGC', _rcvDGCChecked ? 'Y' : 'N');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Delay Notice',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvDLNSwitch,
                          initialValue: _rcvDLNChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvDLNChecked = value;
                              setAlarm('DLN', _rcvDLNChecked ? 'Y' : 'N');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'alarm_vsc'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvVSCSwitch,
                          initialValue: _rcvVSCChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvVSCChecked = value;
                              setAlarm('VSC', _rcvVSCChecked ? 'Y' : 'N');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'alarm_tsc'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvTSCSwitch,
                          initialValue: _rcvTSCChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvTSCChecked = value;
                              setAlarm('TSC', _rcvTSCChecked ? 'Y' : 'N');
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 8, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'alarm_doc'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvDOCSwitch,
                          initialValue: _rcvDOCChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvDOCChecked = value;
                              setAlarm('DOC', _rcvDOCChecked ? 'Y' : 'N');
                            });
                          },
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
      ),
    );
  }
}
