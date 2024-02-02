import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
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
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).colorScheme.outline,
              size: 50,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text('chkingLogin'.tr())
        ],
      ),
    );
  }
}
