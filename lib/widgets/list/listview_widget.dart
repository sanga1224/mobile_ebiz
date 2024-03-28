import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/list/bl_list.dart';
import 'package:mobile_ebiz/popup/schedule/port_list.dart';
import 'package:mobile_ebiz/services/api_list.dart';
import 'package:mobile_ebiz/widgets/bldetail/bldetail_main_widget.dart';
import 'package:mobile_ebiz/widgets/list/percent_indicator.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({
    super.key,
    required this.bound,
    required this.fmdt,
    required this.todt,
    required this.pol,
    required this.pod,
    required this.sortby,
    required this.descending,
  });
  final String bound, fmdt, todt, pol, pod, sortby;
  final bool descending;

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  late String searchBound,
      searchFmdt,
      searchTodt,
      searchPol,
      searchPod,
      searchSortby;
  late bool searchDescending;

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 14)),
  );

  String _pol = '', _polnm = '', _pod = '', _podnm = '';

  setPort(String gb, String code, String name) => setState(() {
        if (gb == 'L') {
          _pol = code;
          _polnm = name;
        } else {
          _pod = code;
          _podnm = name;
        }
      });

  Future<List<BLList>>? _list;
  bool _visibleSearch = false,
      _visibleSort1_up = false,
      _visibleSort1_down = false,
      _visibleSort2_up = false,
      _visibleSort2_down = false,
      _visibleSort3_up = false,
      _visibleSort3_down = false;

  Future search() async {
    setState(() {
      _visibleSort1_up =
          searchSortby == 'etd' && searchDescending == false ? true : false;
      _visibleSort1_down =
          searchSortby == 'etd' && searchDescending == true ? true : false;
      _visibleSort2_up =
          searchSortby == 'eta' && searchDescending == false ? true : false;
      _visibleSort2_down =
          searchSortby == 'eta' && searchDescending == true ? true : false;
      _visibleSort3_up =
          searchSortby == 'blno' && searchDescending == false ? true : false;
      _visibleSort3_down =
          searchSortby == 'blno' && searchDescending == true ? true : false;
      _list = Future.value([]); //초기화하는 즉시 리스트뷰가 없어지지 않음
      _list = ApiList.getList(searchBound, searchFmdt, searchTodt, searchPol,
          searchPod, searchSortby, searchDescending);
      _visibleSearch = false;
    });
  }

  @override
  void initState() {
    super.initState();
    searchBound = widget.bound;
    searchFmdt = widget.fmdt;
    searchTodt = widget.todt;
    searchPol = widget.pol;
    searchPod = widget.pod;
    searchSortby = widget.sortby;
    searchDescending = widget.descending;
    search();
  }

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

    return SingleChildScrollView(
      child: Container(
          clipBehavior: Clip.hardEdge, //Overflow 된 부분 잘라내기
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            width: 1.0,
            color: Theme.of(context).colorScheme.outline,
          ))),
          child: Column(
            children: [
              SizedBox(
                height: 19,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              searchSortby = 'etd';
                              searchDescending =
                                  _visibleSort1_up ? true : false;
                              search();
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
                              searchSortby = 'eta';
                              searchDescending =
                                  _visibleSort2_up ? true : false;
                              search();
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
                        TextButton(
                          onPressed: () {
                            setState(() {
                              searchSortby = 'blno';
                              searchDescending =
                                  _visibleSort3_up ? true : false;
                              search();
                            });
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(
                                left: 8, top: 3, bottom: 0, right: 0),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'B/L No.',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .color,
                                  fontSize: 14,
                                ),
                              ),
                              Visibility(
                                visible: _visibleSort3_up,
                                child: const Icon(
                                  Icons.arrow_upward_outlined,
                                  size: 14,
                                ),
                              ),
                              Visibility(
                                visible: _visibleSort3_down,
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
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _visibleSearch = !_visibleSearch;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(50, 15),
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('detailsearch'.tr()),
                            Icon(!_visibleSearch
                                ? Icons.expand_more_outlined
                                : Icons.expand_less_outlined),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _visibleSearch,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(0, 84, 166, 1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'term'.tr(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Container(
                              height: 40,
                              margin: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 0,
                                bottom: 5,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
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
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          '${start.year}-$startMonth-$startDay ~ ${end.year}-$endMonth-$endDay',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'loading'.tr(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Container(
                              width: 70,
                              height: 40,
                              margin: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 0,
                                bottom: 5,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
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
                                            .displaySmall),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              _polnm,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'discharging'.tr(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Container(
                              width: 70,
                              height: 40,
                              margin: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 0,
                                bottom: 5,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
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
                                            .displaySmall),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              _podnm,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        ),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              searchFmdt = '${start.year}$startMonth$startDay';
                              searchTodt = '${end.year}$endMonth$endDay';
                              searchPol = _pol;
                              searchPod = _pod;
                              search();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(50, 20),
                              backgroundColor:
                                  const Color.fromRGBO(0, 84, 166, 1),
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: const Icon(Icons.search_outlined),
                            label: Text('search'.tr()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: FutureBuilder(
                  future: _list,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Theme.of(context).colorScheme.outline,
                          size: 50,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SearchWidget(
                                              blno:
                                                  snapshot.data![index].blno)));
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data![index].blno,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                    Flexible(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            snapshot.data![index].dg == 'Y'
                                                ? 'DG'
                                                : '',
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data![index].cntr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        '${snapshot.data![index].vslnm}/${snapshot.data![index].vyg}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        '${snapshot.data![index].pol}->${snapshot.data![index].pod}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        snapshot.data![index].etd,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        snapshot.data![index].eta,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    PercentIndicator(
                                      bound: widget.bound,
                                      pickupTransit:
                                          snapshot.data![index].pickupTransit,
                                      returnTransit:
                                          snapshot.data![index].returnTransit,
                                      transit: snapshot.data![index].transit,
                                    ),
                                    // LinearPercentIndicator(
                                    //   animation: true,
                                    //   width: 180,
                                    //   lineHeight: 16,
                                    //   percent: double.parse(
                                    //       snapshot.data![index].transit),
                                    //   center: Text(
                                    //       '${(double.parse(snapshot.data![index].transit) * 100).toStringAsFixed(0)}%'),
                                    //   progressColor: Colors.green,
                                    //   barRadius: const Radius.circular(10),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                            child: Divider(
                              color: Theme.of(context).colorScheme.outline,
                              thickness: 1,
                            ),
                          );
                        },
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return const Center(
                        child: Text(''),
                      );
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }

  Future pickDateRange() async {
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
