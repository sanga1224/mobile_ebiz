import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/bl/bldetail.dart';
import 'package:mobile_ebiz/models/bl/favorite.dart';
import 'package:mobile_ebiz/models/common_function.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/services/api_bl.dart';
import 'package:mobile_ebiz/widgets/bldetail/bldetail1_widget.dart';
import 'package:mobile_ebiz/widgets/bldetail/bldetail2_widget.dart';
import 'package:mobile_ebiz/widgets/bldetail/bldetail3_widget.dart';
import 'package:mobile_ebiz/widgets/bldetail/bldetail4_widget.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, required this.blno});
  final String blno;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  //Ticker가 필요한 애니메이션이 한개인 경우
  TextEditingController txtBlNo = TextEditingController();
  TextEditingController txtFavoriteNickName = TextEditingController();
  Future<BLDetail>? bldetail;
  Future<List<FavoriteBL>>? favoriteBlList;
  bool _isFavorite = false;

  void getFavoriteBLList() {
    favoriteBlList = ApiBL.getFavorite();
  }

  @override
  void initState() {
    txtBlNo = TextEditingController(text: widget.blno);
    bldetail = ApiBL.getBLDetail(txtBlNo.text);
    getFavoriteBLList();
    ApiBL.addRecentBL(widget.blno);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void addFavoriteBL() async {
      StatusMsg result = await ApiBL.addFavorite(
          txtBlNo.text,
          txtFavoriteNickName.text == ''
              ? txtBlNo.text
              : txtFavoriteNickName.text);
      if (result.status == 'Y') {
        setState(() {
          CommonFunction.showSnackBar(context, 'Added_Favorites'.tr(), true);
          getFavoriteBLList();
          Navigator.pop(context);
        });
      }
    }

    void delFavoriteBL() async {
      StatusMsg result = await ApiBL.delFavorite(txtBlNo.text);
      if (result.status == 'Y') {
        setState(() {
          CommonFunction.showSnackBar(context, 'Deleted_Favorites'.tr(), true);
          getFavoriteBLList();
        });
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                    titleSpacing: 10,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 45,
                            width: 250,
                            child: TextField(
                              controller: txtBlNo,
                              onChanged: (value) {
                                txtBlNo.text = txtBlNo.text.toUpperCase();
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.all(10),
                                suffixIcon: InkWell(
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SearchWidget(
                                                    blno: txtBlNo.text)));
                                  },
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              textAlignVertical: TextAlignVertical.top,
                              onSubmitted: (value) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SearchWidget(blno: value)));
                              },
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: favoriteBlList,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              _isFavorite = snapshot.data!.any((item) {
                                if (item.blno == widget.blno) {
                                  return true;
                                } else {
                                  return false;
                                }
                              });

                              return GestureDetector(
                                onTap: () {
                                  if (_isFavorite) {
                                    delFavoriteBL();
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Column(
                                            children: [
                                              Text(
                                                'Input_NickName'.tr(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                              Text(
                                                'No_Input_Blno'.tr(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                              ),
                                            ],
                                          ),
                                          content: TextField(
                                            controller: txtFavoriteNickName,
                                            decoration: InputDecoration(
                                                hintText: txtBlNo.text),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: addFavoriteBL,
                                              child: Text(
                                                'confirm'.tr(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'cancel'.tr(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Icon(
                                  _isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: Colors.red,
                                ),
                              );
                            } else {
                              return const Text('');
                            }
                          },
                        ),
                      ],
                    ),
                    pinned: false,
                    floating: true,
                    bottom: TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Text(
                            'basicInfo'.tr(),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'detailinfo'.tr(),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'cntrinfo'.tr(),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'freightinfo'.tr(),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
                        if (snapshot.data!.auth == 'Y') {
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
                            child: Text(
                              'No Authority',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          );
                        }
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
                        if (snapshot.data!.auth == 'Y') {
                          return ListView(
                            children: [
                              BLDetail3Widget(
                                blno: widget.blno,
                                blInfo: snapshot.data!,
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(
                              'No Authority',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          );
                        }
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
                        if (snapshot.data!.auth == 'Y') {
                          return ListView(
                            children: [
                              BLDetail4Widget(
                                blno: widget.blno,
                                blInfo: snapshot.data!,
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(
                              'No Authority',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          );
                        }
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
