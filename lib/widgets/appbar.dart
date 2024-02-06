import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHome({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2, //AppBar 음영 크기
      foregroundColor: Theme.of(context).appBarTheme.titleTextStyle!.color,
      title: const Text(
        'SINOKOR',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () {
      //       context.read<ThemeProvider>().toggleTheme();
      //     },
      //     icon: const Icon(Icons.refresh_outlined),
      //   ),
      //   IconButton(
      //     onPressed: () {
      //       if (EasyLocalization.of(context)!
      //           .locale
      //           .toString()
      //           .contains('ko')) {
      //         EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));
      //       } else {
      //         EasyLocalization.of(context)!.setLocale(const Locale('ko', 'KR'));
      //       }
      //     },
      //     icon: const Icon(Icons.language_outlined),
      //   ),
      //   IconButton(
      //     onPressed: () {},
      //     icon: const Icon(Icons.menu_rounded),
      //   ),
      // ],
    );
  }
}
