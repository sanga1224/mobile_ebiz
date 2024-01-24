import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'List',
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}
