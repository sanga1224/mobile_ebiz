import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/widgets/list/crossboundlist_widget.dart';
import 'package:mobile_ebiz/widgets/list/inboundlist_widget.dart';
import 'package:mobile_ebiz/widgets/list/outboundlist_widget.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabAlignment: TabAlignment.fill,
            labelColor: Theme.of(context).textTheme.displayLarge!.color,
            indicatorColor: Colors.amberAccent,
            tabs: [
              Tab(child: Text('outbound'.tr())),
              Tab(child: Text('inbound'.tr())),
              Tab(child: Text('crossbound'.tr())),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                OutboundListWidget(),
                InboundListWidget(),
                CrossboundListWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
