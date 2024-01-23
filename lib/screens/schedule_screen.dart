import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/schedule.dart';
import 'package:mobile_ebiz/popup/port_list.dart';
import 'package:mobile_ebiz/services/api_schedule.dart';
import 'package:mobile_ebiz/widgets/schedule_list.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 14)),
  );

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

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    String startMonth = (start.month.toString().length == 1
        ? '0${start.month}'
        : start.month.toString());
    String startDay = (start.day.toString().length == 1
        ? '0${start.day}'
        : start.day.toString());
    String endMonth = (end.month.toString().length == 1
        ? '0${end.month}'
        : end.month.toString());
    String endDay =
        (end.day.toString().length == 1 ? '0${end.day}' : end.day.toString());

    Future search() async {
      if (_pol == '' || _pod == '') {
        final snackBar = SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            '출발지와 도착지를 모두 선택하세요.',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          action: SnackBarAction(
            label: '확인',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        setState(() {
          _schedules = ApiSchedule.getList(
              _pol, _pod, start.year.toString() + startMonth);
        });
      }
    }

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
                                                : '')),
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
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 0,
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
                      children: [
                        TextButton(
                          onPressed: pickDateRange,
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              Text(
                                '${start.year}-$startMonth-$startDay ~ ${end.year}-$endMonth-$endDay',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: search,
                    icon: const Icon(Icons.search_outlined),
                    label: const Text('스케쥴 조회'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).iconTheme.color,
                      foregroundColor: Colors.white.withOpacity(0.8),
                      textStyle: Theme.of(context).textTheme.labelMedium,
                    ),
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
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var schedule in snapshot.data!)
                          ScheduleList(schedule: schedule),
                      ],
                    );
                    // return ListView.builder(
                    //   scrollDirection: Axis.vertical,
                    //   itemCount: snapshot.data!.length,
                    //   itemBuilder: (context, index) {
                    //     var schedule = snapshot.data![index];
                    //     return Column(
                    //       children: [
                    //         Text(schedule.callSign),
                    //       ],
                    //     );
                    //   },
                    // );
                  } else {
                    return Center(
                      child: Text(
                        'No Data',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future pickDateRange() async {
    debugPrint(Theme.of(context).appBarTheme.backgroundColor == Colors.white
        ? "true"
        : "false");
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (context, Widget? child) => Theme(
              data: Theme.of(context).copyWith(
                appBarTheme: Theme.of(context).appBarTheme,
              ),
              child: child!,
            ));

    if (newDateRange == null) return; // pressed 'X'

    setState(() {
      dateRange = newDateRange;
    });
  }
}
