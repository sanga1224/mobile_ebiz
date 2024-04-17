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
  bool _rcvDelayChecked = false;
  ValueNotifier<bool> _rcvDelaySwitch = ValueNotifier(false);
  bool _rcvBkCfmChecked = false;
  ValueNotifier<bool> _rcvBkCfmSwitch = ValueNotifier(false);
  bool _rcvBlIsuChecked = false;
  ValueNotifier<bool> _rcvBlIsuSwitch = ValueNotifier(false);
  bool _rcvFtCfmChecked = false;
  ValueNotifier<bool> _rcvFtCfmSwitch = ValueNotifier(false);

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
            _rcvDelayChecked = snapshot.data!.rcvDelay == 'Y' ? true : false;
            _rcvBkCfmChecked = snapshot.data!.rcvBkCfm == 'Y' ? true : false;
            _rcvBlIsuChecked = snapshot.data!.rcvBlIsu == 'Y' ? true : false;
            _rcvFtCfmChecked = snapshot.data!.rcvFtCfm == 'Y' ? true : false;
            _rcvDelaySwitch = ValueNotifier<bool>(_rcvDelayChecked);
            _rcvBkCfmSwitch = ValueNotifier<bool>(_rcvBkCfmChecked);
            _rcvBlIsuSwitch = ValueNotifier<bool>(_rcvBlIsuChecked);
            _rcvFtCfmSwitch = ValueNotifier<bool>(_rcvFtCfmChecked);

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
                              'alarm_delay'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvDelaySwitch,
                          initialValue: _rcvDelayChecked,
                          onChanged: (value) {
                            debugPrint(value.toString());
                            setState(() {
                              _rcvDelayChecked = value;
                              setAlarm('D', _rcvDelayChecked ? 'Y' : 'N');
                              _rcvDelaySwitch =
                                  ValueNotifier<bool>(_rcvDelayChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvDelaySwitch,
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
                              'alarm_bkcfm'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvBkCfmSwitch,
                          initialValue: _rcvBkCfmChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvBkCfmChecked = value;
                              setAlarm('B', _rcvBkCfmChecked ? 'Y' : 'N');
                              _rcvBkCfmSwitch =
                                  ValueNotifier<bool>(_rcvBkCfmChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvBkCfmSwitch,
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
                              'alarm_blisu'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvBlIsuSwitch,
                          initialValue: _rcvBlIsuChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvBlIsuChecked = value;
                              setAlarm('L', _rcvBlIsuChecked ? 'Y' : 'N');
                              _rcvBlIsuSwitch =
                                  ValueNotifier<bool>(_rcvBlIsuChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvBlIsuSwitch,
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
                              'alarm_ftcfm'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _rcvFtCfmSwitch,
                          initialValue: _rcvFtCfmChecked,
                          onChanged: (value) {
                            setState(() {
                              _rcvFtCfmChecked = value;
                              setAlarm('F', _rcvFtCfmChecked ? 'Y' : 'N');
                              _rcvFtCfmSwitch =
                                  ValueNotifier<bool>(_rcvFtCfmChecked);
                            });
                          },
                          thumb: ValueListenableBuilder<bool>(
                            valueListenable: _rcvFtCfmSwitch,
                            builder: (_, value, __) {
                              return Icon(value
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
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
