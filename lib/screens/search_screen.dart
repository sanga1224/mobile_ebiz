import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/bl/favorite.dart';
import 'package:mobile_ebiz/models/bl/recent.dart';
import 'package:mobile_ebiz/services/api_bl.dart';
import 'package:mobile_ebiz/widgets/bldetail/bldetail_main_widget.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<FavoriteBL>> favoriteBL = ApiBL.getFavorite();
    Future<List<RecentBL>> recentBL = ApiBL.getRecentBL();
    TextEditingController txtBlNo = TextEditingController();

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: txtBlNo,
                onChanged: (value) {
                  txtBlNo.text = txtBlNo.text.toUpperCase();
                },
                decoration: InputDecoration(
                  labelText: 'B/L No.',
                  suffix: InkWell(
                    child: const Icon(Icons.search),
                    onTap: () {
                      Navigator.push(
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
                onSubmitted: (value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SearchWidget(blno: value)));
                },
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
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
                        options: CarouselOptions(
                          height: 100,
                          showIndicator: true,
                          slideIndicator: const CircularSlideIndicator(),
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
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                                            fontSize: 22,
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
        Expanded(
          flex: 2,
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
                        options: CarouselOptions(
                          height: 100,
                          showIndicator: true,
                          slideIndicator: const CircularSlideIndicator(),
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
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              e.blno,
                                              style: const TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              e.cntr,
                                              style: const TextStyle(
                                                fontSize: 15,
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                '${e.vslnm}/${e.vyg}',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                '${e.pol}->${e.pod}',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
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
    );
  }
}
