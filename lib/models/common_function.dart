import 'package:flutter/material.dart';

class CommonFunction {
  static void showSnackBar(BuildContext context, String text, bool positive) {
    Text content = Text(
      text,
      style: Theme.of(context).textTheme.displaySmall,
    );
    final snackBar = SnackBar(
      content: content,
      backgroundColor:
          positive == true ? const Color.fromRGBO(0, 84, 166, 1) : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
