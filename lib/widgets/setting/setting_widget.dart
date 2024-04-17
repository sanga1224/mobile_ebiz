import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:mobile_ebiz/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget(
      {super.key, required this.savedThemeMode, required this.curLocale});
  final String savedThemeMode, curLocale;

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  bool _darkModeChecked = false;
  ValueNotifier<bool> _darkModeSwitch = ValueNotifier<bool>(false);
  List<String> lstLanguage = <String>['ENG', 'KOR'];
  String? _selectedLanguage;

  void changeTheme() {}

  @override
  void initState() {
    super.initState();

    if (widget.curLocale.contains('ko')) {
      _selectedLanguage = 'KOR';
    } else {
      _selectedLanguage = 'ENG';
    }

    if (widget.savedThemeMode == 'light') {
      _darkModeChecked = false;
    } else {
      _darkModeChecked = true;
    }
    _darkModeSwitch = ValueNotifier<bool>(_darkModeChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2, //AppBar 음영 크기
        foregroundColor: Theme.of(context).appBarTheme.titleTextStyle!.color,
        title: Text(
          'more'.tr(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.language_outlined),
                          const SizedBox(width: 10),
                          Text(
                            'language'.tr(),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                      DropdownButton(
                        items: lstLanguage
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _selectedLanguage,
                        onChanged: (String? value) {
                          if (value == 'KOR') {
                            setState(() {
                              _selectedLanguage = value ?? '';
                              EasyLocalization.of(context)!
                                  .setLocale(const Locale('ko', 'KR'));
                            });
                          } else {
                            setState(() {
                              _selectedLanguage = value ?? '';
                              EasyLocalization.of(context)!
                                  .setLocale(const Locale('en', 'US'));
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4, bottom: 8, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.dark_mode_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'dark_mode'.tr(),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                      AdvancedSwitch(
                        controller: _darkModeSwitch,
                        initialValue: _darkModeChecked,
                        onChanged: (value) {
                          setState(() {
                            if (_darkModeChecked) {
                              _darkModeChecked = false;
                            } else {
                              _darkModeChecked = true;
                            }
                            context.read<ThemeProvider>().toggleTheme();
                            _darkModeSwitch =
                                ValueNotifier<bool>(_darkModeChecked);
                          });
                        },
                        thumb: ValueListenableBuilder<bool>(
                          valueListenable: _darkModeSwitch,
                          builder: (_, value, __) {
                            return Icon(value
                                ? Icons.lightbulb
                                : Icons.lightbulb_outline);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
