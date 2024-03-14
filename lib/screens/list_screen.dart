import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/widgets/list/listview_widget.dart';

class ListScreen extends StatefulWidget {
  const ListScreen(
      {super.key,
      required this.bound,
      required this.fmdt,
      required this.todt,
      required this.pol,
      required this.pod});
  final String bound, fmdt, todt, pol, pod;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.bound == 'O') {
      _tabController.index = 0;
    } else if (widget.bound == 'I') {
      _tabController.index = 1;
    } else {
      _tabController.index = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabAlignment: TabAlignment.fill,
          labelColor: Theme.of(context).textTheme.displayLarge!.color,
          indicatorColor: Colors.amberAccent,
          tabs: [
            Tab(child: Text('outbound'.tr())),
            Tab(child: Text('inbound'.tr())),
            Tab(child: Text('crossbound'.tr())),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ListViewWidget(
                bound: 'O',
                fmdt: widget.fmdt,
                todt: widget.todt,
                pol: widget.pol,
                pod: widget.pod,
              ),
              ListViewWidget(
                bound: 'I',
                fmdt: widget.fmdt,
                todt: widget.todt,
                pol: widget.pol,
                pod: widget.pod,
              ),
              ListViewWidget(
                bound: 'C',
                fmdt: widget.fmdt,
                todt: widget.todt,
                pol: widget.pol,
                pod: widget.pod,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
