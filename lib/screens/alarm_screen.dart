import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/alarm/message.dart';
import 'package:mobile_ebiz/popup/alarm/alarm_detail.dart';
import 'package:mobile_ebiz/services/api_alarm.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Message>> message = ApiAlarm.getMsgList();

    return SingleChildScrollView(
      child: Container(
        clipBehavior: Clip.hardEdge, //Overflow 된 부분 잘라내기
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: FutureBuilder(
            future: message,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Theme.of(context).colorScheme.outline,
                    size: 50,
                  ),
                );
              } else if (snapshot.hasData) {
                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => AlarmDetail(
                              title: snapshot.data![index].title,
                              contents: snapshot.data![index].contents,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data![index].title,
                            style: Theme.of(context).textTheme.displayMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            snapshot.data![index].contents,
                            style: Theme.of(context).textTheme.displaySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
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
                );
              } else {
                return const Center(child: Text('No data'));
              }
            },
          ),
        ),
      ),
    );
  }
}
