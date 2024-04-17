import 'package:flutter/material.dart';

class AlarmDetail extends StatelessWidget {
  const AlarmDetail({super.key, required this.title, required this.contents});
  final String title, contents;

  @override
  Widget build(BuildContext context) {
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
