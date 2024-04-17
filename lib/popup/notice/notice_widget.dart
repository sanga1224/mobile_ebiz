import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/account/notice.dart';
import 'package:mobile_ebiz/services/api_notice.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeWidget extends StatelessWidget {
  const NoticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Notice>> notice = ApiNotice.getList();

    return Scaffold(
      appBar: AppBar(
        elevation: 2, //AppBar 음영 크기
        foregroundColor: Theme.of(context).appBarTheme.titleTextStyle!.color,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'notice'.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: notice,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Theme.of(context).colorScheme.outline,
                size: 50,
              ),
            );
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse(
                          'http://www.sinokor.co.kr/Notice/Detail?nacd=${snapshot.data![index].nacd}&num=${snapshot.data![index].seq}'));
                    },
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   width: 1,
                        //   color: Theme.of(context).colorScheme.primary,
                        // ),
                        // borderRadius:
                        //     const BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40,
                              child: Text(snapshot.data![index].title),
                            ),
                            SizedBox(
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(snapshot.data![index].inpdate),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 5,
                    child: Divider(
                      color: Theme.of(context).colorScheme.outline,
                      thickness: 1,
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              ),
            );
          } else {
            return const Text('');
          }
        },
      ),
    );
  }
}
