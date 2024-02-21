import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/bldetail/bldetail.dart';
import 'package:mobile_ebiz/services/api_bldetail.dart';
import 'package:mobile_ebiz/widgets/bldetail/bldetail1_widget.dart';
import 'package:mobile_ebiz/widgets/bldetail/bldetail2_widget.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, required this.blno});
  final String blno;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  //Ticker가 필요한 애니메이션이 한개인 경우
  TextEditingController txtBlNo = TextEditingController();
  Future<BLDetail>? bldetail;

  @override
  void initState() {
    txtBlNo = TextEditingController(text: widget.blno);
    bldetail = ApiBLDetail.getBLDetail(txtBlNo.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  titleSpacing: 10,
                  title: Center(
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: txtBlNo,
                        onChanged: (value) {
                          txtBlNo.text = txtBlNo.text.toUpperCase();
                        },
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
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ),
                  ),
                  pinned: false,
                  floating: true,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(child: Text('basicInfo'.tr())),
                      Tab(child: Text('detailinfo'.tr())),
                      Tab(child: Text('cntrinfo'.tr())),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                FutureBuilder(
                  future: bldetail,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: [
                          BLDetail1Widget(
                            blno: widget.blno,
                            blInfo: snapshot.data!,
                          ),
                        ],
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
                FutureBuilder(
                  future: bldetail,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: [
                          BLDetail2Widget(
                            blno: widget.blno,
                            blInfo: snapshot.data!,
                          ),
                        ],
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
                const Center(
                  child: Text('Tracking'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
