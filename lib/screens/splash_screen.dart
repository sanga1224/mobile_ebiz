import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/images/logo_41px.png'),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'SINOKOR',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      )),
    );
  }
}
