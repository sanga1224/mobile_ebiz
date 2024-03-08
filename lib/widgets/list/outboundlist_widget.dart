import 'package:flutter/material.dart';

class OutboundListWidget extends StatelessWidget {
  const OutboundListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Text('B/L List'),
        ],
      ),
    );
  }
}
