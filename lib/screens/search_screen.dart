import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/bl/favorite.dart';
import 'package:mobile_ebiz/models/bl/recent.dart';
import 'package:mobile_ebiz/models/common_function.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/services/api_bl.dart';
import 'package:mobile_ebiz/widgets/bldetail/bldetail_main_widget.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:mobile_ebiz/widgets/bldetail/search_blno_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLogin = false;
  Future<List<FavoriteBL>>? favoriteBL;
  Future<List<RecentBL>>? recentBL;

  @override
  void initState() {
    super.initState();
    CommonFunction.isLogin().then((value) {
      isLogin = value;
      if (isLogin) {
        getFavoriteBL();
        getRecentBL();
      }
    });
  }

  void getFavoriteBL() {
    setState(() {
      favoriteBL = ApiBL.getFavorite();
    });
  }

  void addRecentBL(String blno) {
    Future<StatusMsg> status = ApiBL.addRecentBL(blno);
    status.then((value) {
      getRecentBL();
    });
  }

  void getRecentBL() {
    setState(() {
      recentBL = ApiBL.getRecentBL();
    });
  }

  void delRecentBL(String blno) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      title: '',
      text: 'delete?'.tr(),
      confirmBtnText: 'yes'.tr(),
      cancelBtnText: 'no'.tr(),
      onConfirmBtnTap: () {
        Future<StatusMsg> status = ApiBL.delRecentBL(blno);
        status.then((value) {
          if (value.status == 'Y') {
            getRecentBL();
            CommonFunction.showSnackBar(context, 'Delete_Completed'.tr(), true);
          } else {
            CommonFunction.showSnackBar(context, 'Error_Occured'.tr(), false);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //Focus out을 위한 detector
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 20),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SearchBlNoWidget(
                    isLogin: isLogin,
                    func: addRecentBL,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: FutureBuilder(
                future: favoriteBL,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'mybl'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          FlutterCarousel(
                            options: FlutterCarouselOptions(
                              height: 100,
                              showIndicator: true,
                              slideIndicator: CircularSlideIndicator(),
                            ),
                            items: snapshot.data!.map((e) {
                              return Builder(
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SearchWidget(blno: e.blno)));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.msg,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              e.blno,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          )
                        ],
                      );
                    } else {
                      return const Text('');
                    }
                  } else {
                    return const Text('');
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: FutureBuilder(
                future: recentBL,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'recentbl'.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          FlutterCarousel(
                            options: FlutterCarouselOptions(
                              height: 120,
                              showIndicator: true,
                              slideIndicator: CircularSlideIndicator(),
                            ),
                            items: snapshot.data!.map((e) {
                              return Builder(
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SearchWidget(blno: e.blno)));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    delRecentBL(e.blno);
                                                  },
                                                  child: const Icon(
                                                    Icons.close_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    e.blno,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  e.cntr,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    '${e.vslnm}/${e.vyg}',
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    '${e.pol}->${e.pod}',
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          )
                        ],
                      );
                    } else {
                      return const Text('');
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
    );
  }
}
