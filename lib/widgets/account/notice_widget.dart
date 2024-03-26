import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/account/notice.dart';
import 'package:mobile_ebiz/services/api_notice.dart';

class NoticeWidget extends StatelessWidget {
  const NoticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Notice>> notice = ApiNotice.getList(0);

    return Scaffold(
      appBar: AppBar(
        elevation: 2, //AppBar 음영 크기
        foregroundColor: Theme.of(context).appBarTheme.titleTextStyle!.color,
        title: Text(
          'notice'.tr(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(snapshot.data![index].title),
                            ],
                          ),
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
                  ),
                );
              } else {
                return const Text('');
              }
            },
          ),
        ),
      ),
    );
  }
}
