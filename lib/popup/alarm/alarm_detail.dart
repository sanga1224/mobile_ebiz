import 'package:flutter/material.dart';
import 'package:mobile_ebiz/main.dart';
import 'package:mobile_ebiz/services/api_alarm.dart';

class AlarmDetail extends StatelessWidget {
  const AlarmDetail(
      {super.key,
      required this.refno,
      required this.title,
      required this.contents});
  final String refno, title, contents;

  @override
  Widget build(BuildContext context) {
    void getCount() async {
      msgCountGlobal.value = await ApiAlarm.setRead(refno);
    }

    getCount();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'alarm_detail',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.replaceAll('\r', '\n'),
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                contents.replaceAll('\r', '\n'),
                style: Theme.of(context).textTheme.displaySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
