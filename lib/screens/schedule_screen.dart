import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/common_function.dart';
import 'package:mobile_ebiz/models/schedule/schedule.dart';
import 'package:mobile_ebiz/popup/schedule/port_list.dart';
import 'package:mobile_ebiz/services/api_schedule.dart';
import 'package:mobile_ebiz/widgets/schedule/schedule_widget.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedDate = DateTime.now();
  String _pol = 'KRPUS', _polnm = 'Busan', _pod = 'CNSHA', _podnm = 'Shanghai';

  setPort(String gb, String code, String name) => setState(() {
        if (gb == 'L') {
          _pol = code;
          _polnm = name;
        } else {
          _pod = code;
          _podnm = name;
        }
      });

  changePolPod() => setState(() {
        String pol = _pol, polnm = _polnm, pod = _pod, podnm = _podnm;
        _pol = pod;
        _polnm = podnm;
        _pod = pol;
        _podnm = polnm;
      });

  Future<List<Schedule>>? _schedules;

  Future search(String pol, String pod, String yyyymm) async {
    if (pol == '') {
      CommonFunction.showSnackBar(context, 'Input_POL'.tr(), false);
    }
    if (pod == '') {
      CommonFunction.showSnackBar(context, 'Input_POD'.tr(), false);
    } else {
      setState(() {
        _schedules = ApiSchedule.getList(pol, pod, yyyymm);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    search(
        _pol,
        _pod,
        _selectedDate.year.toString() +
            (_selectedDate.month.toString().length == 1
                ? '0${_selectedDate.month}'
                : _selectedDate.month.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PortList(
                                            gb: 'L',
                                            func: setPort,
                                            initNation: (_pol != ''
                                                ? _pol.substring(0, 2)
                                                : '')),
                                        fullscreenDialog: true,
                                      ));
                                },
                                child: Text(_pol,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge),
                              ),
                              Text(
                                _polnm,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: changePolPod,
                                icon: Icon(
                                  Icons.change_circle_outlined,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PortList(
                                          gb: 'D',
                                          func: setPort,
                                          initNation: (_pod != ''
                                              ? _pod.substring(0, 2)
                                              : ''),
                                        ),
                                        fullscreenDialog: true,
                                      ));
                                },
                                child: Text(_pod,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge),
                              ),
                              Text(
                                _podnm,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 0,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 40,
                        width: 150,
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: pickMonth,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '${_selectedDate.year}-${_selectedDate.month.toString().length == 1 ? '0${_selectedDate.month}' : _selectedDate.month.toString()}',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            search(_pol, _pod,
                                '${_selectedDate.year}${_selectedDate.month.toString().length == 1 ? '0${_selectedDate.month}' : _selectedDate.month.toString()}');
                          },
                          icon: const Icon(Icons.search_outlined),
                          label: Text('${'schedule'.tr()} ${'search'.tr()}'),
                          style: Theme.of(context).elevatedButtonTheme.style,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: _schedules,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Theme.of(context).colorScheme.outline,
                      size: 50,
                    ),
                  );
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      for (var schedule in snapshot.data!)
                        ScheduleList(schedule: schedule),
                    ],
                  );
                } else {
                  return Center(
                    child: Text(
                      '',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Future pickMonth() async {
  //   _selectedDate =
  // }
  Future pickMonth() async {
    await showCupertinoModalPopup(
        context: context,
        builder: (_) {
          final size = MediaQuery.of(context).size;
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            height: size.height * 0.27,
            child: CupertinoMonthPicker(
              initDateStr: _selectedDate,
              onDateTimeChanged: (datetime) {
                setState(() {
                  _selectedDate = datetime;
                });
              },
            ),
          );
        });
  }
}

class CupertinoMonthPicker extends StatelessWidget {
  const CupertinoMonthPicker(
      {super.key, required this.initDateStr, required this.onDateTimeChanged});
  final DateTime initDateStr;
  final void Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    // final initDate = DateFormat('yyyy-MM-dd').parse(initDateStr);
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200, // 날짜 및 시간을 선택할 수 있는 CupertinoDatePicker 위젯.
              child: CupertinoDatePicker(
                // 초기에 선택된 날짜와 시간.
                initialDateTime: initDateStr, // 날짜나 시간이 변경될 때 호출되는 콜백 함수.
                onDateTimeChanged:
                    onDateTimeChanged, // 날짜와 시간을 모두 선택할 수 있도록 설정.
                mode: CupertinoDatePickerMode.monthYear, // 24시간 형식을 사용하도록 설정.
                minimumYear:
                    DateTime.now().year - 5, // 선택 가능한 최대 연도를 현재 연도로 설정.
                maximumYear: DateTime.now().year + 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
