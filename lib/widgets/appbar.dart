import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/widgets/setting/setting_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHome({super.key});

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
      actions: [
        IconButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            final String? savedThemeMode = prefs.getString('themeMode');
            if (!context.mounted) {
              return; //async-await gap 때문에 context가 null일 수 있어 추가 필요.
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingWidget(
                      savedThemeMode: savedThemeMode ?? 'light',
                      curLocale:
                          EasyLocalization.of(context)!.locale.toString()),
                  fullscreenDialog: true,
                ));
          },
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
    );
  }
}
