import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/account/profile.dart';
import 'package:mobile_ebiz/models/common_function.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/services/api_login.dart';

class AlarmWidget extends StatefulWidget {
  const AlarmWidget({super.key});

  @override
  State<AlarmWidget> createState() => _AlarmWidgetState();
}

class _AlarmWidgetState extends State<AlarmWidget> {
  final Future<Profile> _profile = ApiLogIn.getProfile(0);
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
  }

  @override
  Widget build(BuildContext context) {
    void setAlarm(String gb, String val) async {
      StatusMsg result = await ApiLogIn.updateAlarm(gb, val);
      if (!context.mounted) {
        return; //async-await gap 때문에 context가 null일 수 있어 추가 필요.
      }
      if (result.status == 'Y') {
        CommonFunction.showSnackBar(
            context, 'alarm_setting_completed'.tr(), true);
      } else {
        CommonFunction.showSnackBar(
            context, 'alarm_setting_failed'.tr(), false);
      }
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
            _rcvBLCChecked = snapshot.data!.blc == 'Y' ? true : false;
            _rcvCACChecked = snapshot.data!.cac == 'Y' ? true : false;
            _rcvBLIChecked = snapshot.data!.bli == 'Y' ? true : false;
            _rcvBLPChecked = snapshot.data!.blp == 'Y' ? true : false;
            _rcvLCCChecked = snapshot.data!.lcc == 'Y' ? true : false;
            _rcvIVIChecked = snapshot.data!.ivi == 'Y' ? true : false;
            _rcvTXIChecked = snapshot.data!.txi == 'Y' ? true : false;
            _rcvFTCChecked = snapshot.data!.ftc == 'Y' ? true : false;
            _rcvDGCChecked = snapshot.data!.dgc == 'Y' ? true : false;
            _rcvDLNChecked = snapshot.data!.dln == 'Y' ? true : false;
            _rcvVSCChecked = snapshot.data!.vsc == 'Y' ? true : false;
            _rcvTSCChecked = snapshot.data!.tsc == 'Y' ? true : false;
            _rcvDOCChecked = snapshot.data!.doc == 'Y' ? true : false;

            _rcvBKCSwitch = ValueNotifier<bool>(_rcvBKCChecked);
            _rcvBLCSwitch = ValueNotifier<bool>(_rcvBLCChecked);
            _rcvCACSwitch = ValueNotifier<bool>(_rcvCACChecked);
            _rcvBLISwitch = ValueNotifier<bool>(_rcvBLIChecked);
            _rcvBLPSwitch = ValueNotifier<bool>(_rcvBLPChecked);
            _rcvLCCSwitch = ValueNotifier<bool>(_rcvLCCChecked);
            _rcvIVISwitch = ValueNotifier<bool>(_rcvIVIChecked);
            _rcvTXISwitch = ValueNotifier<bool>(_rcvTXIChecked);
            _rcvFTCSwitch = ValueNotifier<bool>(_rcvFTCChecked);
            _rcvDGCSwitch = ValueNotifier<bool>(_rcvDGCChecked);
            _rcvDLNSwitch = ValueNotifier<bool>(_rcvDLNChecked);
            _rcvVSCSwitch = ValueNotifier<bool>(_rcvVSCChecked);
            _rcvTSCSwitch = ValueNotifier<bool>(_rcvTSCChecked);
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
                            debugPrint(value.toString());
                            setState(() {
                              _rcvBKCChecked = value;
                              setAlarm('BKC', _rcvBKCChecked ? 'Y' : 'N');
                              _rcvBKCSwitch =
                                  ValueNotifier<bool>(_rcvBKCChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvBKCSwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
                              _rcvBLCSwitch =
                                  ValueNotifier<bool>(_rcvBLCChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvBLCSwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
                              _rcvCACSwitch =
                                  ValueNotifier<bool>(_rcvCACChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvCACSwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
                              _rcvBLISwitch =
                                  ValueNotifier<bool>(_rcvBLIChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvBLISwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
                              _rcvBLPSwitch =
                                  ValueNotifier<bool>(_rcvBLPChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvBLPSwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
                              _rcvLCCSwitch =
                                  ValueNotifier<bool>(_rcvLCCChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvLCCSwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
                              _rcvIVISwitch =
                                  ValueNotifier<bool>(_rcvIVIChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvIVISwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
                              _rcvTXISwitch =
                                  ValueNotifier<bool>(_rcvTXIChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvTXISwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
                              _rcvFTCSwitch =
                                  ValueNotifier<bool>(_rcvFTCChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvFTCSwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
                              _rcvDGCSwitch =
                                  ValueNotifier<bool>(_rcvDGCChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvDGCSwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
                              'alarm_dln'.tr(),
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
                              _rcvDLNSwitch =
                                  ValueNotifier<bool>(_rcvDLNChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvDLNSwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
                              _rcvVSCSwitch =
                                  ValueNotifier<bool>(_rcvVSCChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvVSCSwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
                              _rcvTSCSwitch =
                                  ValueNotifier<bool>(_rcvTSCChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvTSCSwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
                              _rcvDOCSwitch =
                                  ValueNotifier<bool>(_rcvDOCChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvDOCSwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
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
