import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/screens/account_screen.dart';
import 'package:mobile_ebiz/services/api_login.dart';
import 'package:mobile_ebiz/widgets/list/listview_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Future<bool> isLogIn() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? loginToken = prefs.getString('login_token');

      if (loginToken != null) {
        StatusMsg result = await ApiLogIn.chkLogIn();
        if (result.status == "Y") {
          return true;
        } else {
          prefs.setString('login_token', '');
          return false;
        }
      } else {
        return false;
      }
    }

    return FutureBuilder(
      future: isLogIn(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.hasData) {
          if (snapshot.data == true) {
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
                        sortby: 'etd',
                        descending: false,
                      ),
                      ListViewWidget(
                        bound: 'I',
                        fmdt: widget.fmdt,
                        todt: widget.todt,
                        pol: widget.pol,
                        pod: widget.pod,
                        sortby: 'etd',
                        descending: false,
                      ),
                      ListViewWidget(
                        bound: 'C',
                        fmdt: widget.fmdt,
                        todt: widget.todt,
                        pol: widget.pol,
                        pod: widget.pod,
                        sortby: 'etd',
                        descending: false,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const AccountScreen(
              returnPage: 'List',
            );
          }
        } else {
          return const Text('');
        }
      },
    );
  }
}
