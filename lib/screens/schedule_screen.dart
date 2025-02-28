import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/common_function.dart';
import 'package:mobile_ebiz/models/schedule/myschedule.dart';
import 'package:mobile_ebiz/models/schedule/schedule.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/popup/schedule/port_list.dart';
import 'package:mobile_ebiz/services/api_schedule.dart';
import 'package:mobile_ebiz/widgets/schedule/schedule_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen(
      {super.key,
      required this.pol,
      required this.polnm,
      required this.pod,
      required this.podnm,
      required this.yyyymm});
  final String pol, polnm, pod, podnm, yyyymm;

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedDate = DateTime.now();
  late String _pol, _polnm, _pod, _podnm, _yyyymm, _sortBy;
  late bool _descending, _isFavorites = false;
  Future<List<Schedule>>? _schedules;
  Future<List<MySchedule>>? _mySchedule;
  bool _visibleSort1_up = false,
      _visibleSort1_down = false,
      _visibleSort2_up = false,
      _visibleSort2_down = false;

  setPort(String gb, String code, String name) => setState(() {
        if (gb == 'L') {
          _pol = code;
          _polnm = name;
        } else {
          _pod = code;
          _podnm = name;
        }
        checkFavorites();
      });

  changePolPod() => setState(() {
        String pol = _pol, polnm = _polnm, pod = _pod, podnm = _podnm;
        _pol = pod;
        _polnm = podnm;
        _pod = pol;
        _podnm = polnm;
        checkFavorites();
      });

  Future search(String pol, String pod, String yyyymm, String sortBy,
      bool descending) async {
    _visibleSort1_up = sortBy == 'etd' && descending == false ? true : false;
    _visibleSort1_down = sortBy == 'etd' && descending == true ? true : false;
    _visibleSort2_up = sortBy == 'eta' && descending == false ? true : false;
    _visibleSort2_down = sortBy == 'eta' && descending == true ? true : false;
    if (pol == '') {
      CommonFunction.showSnackBar(context, 'Input_POL'.tr(), false);
    }
    if (pod == '') {
      CommonFunction.showSnackBar(context, 'Input_POD'.tr(), false);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'recentSchedule', '$pol|$_polnm|$pod|$_podnm|$yyyymm');
      setState(() {
        _schedules = ApiSchedule.getList(pol, pod, yyyymm, sortBy, descending);
        //즐겨찾기 체크
        checkFavorites();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMySchedule();
    _pol = 'KRPUS';
    _polnm = 'Busan';
    _pod = 'CNSHA';
    _podnm = 'Shanghai';
    _yyyymm = _selectedDate.year.toString() +
        (_selectedDate.month.toString().length == 1
            ? '0${_selectedDate.month}'
            : _selectedDate.month.toString());
    _sortBy = 'etd';
    _descending = false;
    _visibleSort1_up = true;

    Future<String> futureStr = getRecentSchedule();
    futureStr.then((recentSchedule) {
      if (widget.pol != '' && widget.pod != '') {
        _pol = widget.pol;
        _polnm = widget.polnm;
        _pod = widget.pod;
        _podnm = widget.podnm;
        _yyyymm = widget.yyyymm;
      } else {
        if (recentSchedule != '') {
          List<String> lst = recentSchedule.split('|');
          setState(() {
            _pol = lst[0];
            _polnm = lst[1];
            _pod = lst[2];
            _podnm = lst[3];
            _yyyymm = lst[4];
          });
        }
      }
      search(_pol, _pod, _yyyymm, _sortBy, _descending);
    });
  }

  void checkFavorites() {
    _mySchedule?.then((my) {
      _isFavorites = my.any((item) {
        if (item.pol == _pol && item.pod == _pod) {
          return true;
        } else {
          return false;
        }
      });
    });
  }

  Future<String> getRecentSchedule() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('recentSchedule') ?? '';
  }

  Future getMySchedule() async {
    _mySchedule = ApiSchedule.getMySchedule();
  }

  void addFavorites() async {
    StatusMsg result = await ApiSchedule.addMySchedule(_pol, _pod);
    if (result.status == 'Y') {
      if (context.mounted) {
        return; //async-await gap 때문에 context가 null일 수 있어 추가 필요.
      }
      CommonFunction.showSnackBar(context, 'Added_Favorites'.tr(), true);
    }

    setState(() {
      getMySchedule();
      _isFavorites = true;
    });
  }

  void delFavorites() async {
    StatusMsg result = await ApiSchedule.delMySchedule(_pol, _pod);
    if (result.status == 'Y') {
      if (!context.mounted) {
        return; //async-await gap 때문에 context가 null일 수 있어 추가 필요.
      }
      CommonFunction.showSnackBar(context, 'Deleted_Favorites'.tr(), true);
    }

    setState(() {
      _isFavorites = false;
      getMySchedule();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 8, left: 8, right: 8),
        child: Column(
          children: [
            SizedBox(
              child: Column(
                children: [
                  FutureBuilder(
                    future: _mySchedule,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          List<OptionItem> optionItemList = [];
                          for (MySchedule my in snapshot.data!) {
                            optionItemList.add(
                              OptionItem(
                                id: '${my.pol}|${my.polnm}|${my.pod}|${my.podnm}',
                                title: '${my.pol} -> ${my.pod}',
                              ),
                            );
                          }
                          DropListModel dropListModel =
                              DropListModel(optionItemList);
                          OptionItem optionItemSelected =
                              OptionItem(title: 'favorites'.tr());

                          return SelectDropList(
                            containerPadding: const EdgeInsets.all(5),
                            itemSelected: optionItemSelected,
                            dropListModel: dropListModel,
                            showIcon: true,
                            showArrowIcon: true,
                            showBorder: true,
                            paddingTop: 0,
                            paddingBottom: 0,
                            paddingLeft: 10,
                            paddingRight: 10,
                            icon: const Icon(
                              Icons.favorite_outline,
                              color: Colors.grey,
                            ),
                            onOptionSelected: (optionItem) {
                              optionItemSelected = optionItem;
                              setState(() {
                                List<String> items =
                                    optionItem.id.toString().split('|');
                                _pol = items[0];
                                _polnm = items[1];
                                _pod = items[2];
                                _podnm = items[3];
                                search(
                                    _pol, _pod, _yyyymm, _sortBy, _descending);
                              });
                            },
                            textSizeTitle: 14,
                            height: 40,
                          );
                        } else {
                          return const Text('');
                        }
                      } else {
                        return const Text('');
                      }
                    },
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
                              SizedBox(
                                height: 30,
                                child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: changePolPod,
                                  icon: Icon(
                                    Icons.change_circle_outlined,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                child: FutureBuilder(
                                  future: _mySchedule,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.isNotEmpty) {
                                        _isFavorites =
                                            snapshot.data!.any((item) {
                                          if (item.pol == _pol &&
                                              item.pod == _pod) {
                                            return true;
                                          } else {
                                            return false;
                                          }
                                        });

                                        return IconButton(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: _isFavorites
                                              ? delFavorites
                                              : addFavorites,
                                          icon: Icon(
                                            _isFavorites
                                                ? Icons.favorite
                                                : Icons.favorite_outline,
                                            color: Colors.red,
                                          ),
                                        );
                                      } else {
                                        _isFavorites = false;

                                        return IconButton(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: _isFavorites
                                              ? delFavorites
                                              : addFavorites,
                                          icon: Icon(
                                            _isFavorites
                                                ? Icons.favorite
                                                : Icons.favorite_outline,
                                            color: Colors.red,
                                          ),
                                        );
                                      }
                                    } else {
                                      return const Text('');
                                    }
                                  },
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
                                    '${_yyyymm.substring(0, 4)}-${_yyyymm.substring(4)}',
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
                            search(_pol, _pod, _yyyymm, _sortBy, _descending);
                          },
                          icon: const Icon(
                            Icons.search_outlined,
                            color: Colors.white,
                          ),
                          label: Text('${'schedule'.tr()} ${'search'.tr()}'),
                          style: Theme.of(context).elevatedButtonTheme.style,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _sortBy = 'etd';
                            _descending = _visibleSort1_up ? true : false;
                            search(_pol, _pod, _yyyymm, _sortBy, _descending);
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(
                              left: 8, top: 3, bottom: 0, right: 0),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'ETD',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .color,
                                fontSize: 14,
                              ),
                            ),
                            Visibility(
                              visible: _visibleSort1_up,
                              child: const Icon(
                                Icons.arrow_upward_outlined,
                                size: 14,
                              ),
                            ),
                            Visibility(
                              visible: _visibleSort1_down,
                              child: const Icon(
                                Icons.arrow_downward_outlined,
                                size: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _sortBy = 'eta';
                            _descending = _visibleSort2_up ? true : false;
                            search(_pol, _pod, _yyyymm, _sortBy, _descending);
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(
                              left: 8, top: 3, bottom: 0, right: 0),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'ETA',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .color,
                                fontSize: 14,
                              ),
                            ),
                            Visibility(
                              visible: _visibleSort2_up,
                              child: const Icon(
                                Icons.arrow_upward_outlined,
                                size: 14,
                              ),
                            ),
                            Visibility(
                              visible: _visibleSort2_down,
                              child: const Icon(
                                Icons.arrow_downward_outlined,
                                size: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
              color: Theme.of(context).colorScheme.surface,
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
                  _yyyymm =
                      '${_selectedDate.year}${_selectedDate.month.toString().length == 1 ? '0${_selectedDate.month}' : _selectedDate.month.toString()}';
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
