import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/bldetail/schedule.dart';
import 'package:mobile_ebiz/services/api_bldetail.dart';
import 'package:mobile_ebiz/widgets/bldetail/schedule_widget.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, required this.blno});
  final String blno;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  //Ticker가 필요한 애니메이션이 한개인 경우
  TextEditingController txtBlNo = TextEditingController();
  Future<List<BookingSchedule>>? schedule;

  @override
  void initState() {
    txtBlNo = TextEditingController(text: widget.blno);
    schedule = ApiBLDetail.getSchedule(txtBlNo.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                titleSpacing: 30,
                title: Center(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: txtBlNo,
                      onChanged: (value) => value.toUpperCase(),
                      decoration: InputDecoration(
                        suffix: InkWell(
                          child: const Icon(Icons.search),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SearchWidget(blno: txtBlNo.text)));
                          },
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                pinned: false,
                floating: true,
                bottom: TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(child: Text('schedule'.tr())),
                    Tab(child: Text('detailinfo'.tr())),
                    Tab(child: Text('tracking'.tr())),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              FutureBuilder(
                future: schedule,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return BookingScheduleWidget(schedules: snapshot.data!);
                  } else {
                    return const Center(
                      child: Text('Nothing'),
                    );
                  }
                },
              ),
              const Center(
                child: Text('Detail'),
              ),
              const Center(
                child: Text('Tracking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
