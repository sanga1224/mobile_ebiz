import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/services/api_login.dart';
import 'package:mobile_ebiz/widgets/account/login_widget.dart';
import 'package:mobile_ebiz/widgets/account/setting_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> isLogIn() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? loginToken = prefs.getString('login_token');

      if (loginToken != null) {
        StatusMsg result = await ApiLogIn.chkLogIn();
        if (result.status == "Y") {
          return true;
        } else {
          prefs.setString('login_token', '');
          return false;
        }
      } else {
        return false;
      }
    }

    return Center(
      child: FutureBuilder(
        future: isLogIn(),
        builder: (context, snapshot) {
          return _loadingWidget(snapshot);
        },
      ),
    );
  }
}

Widget _loadingWidget(AsyncSnapshot<Object?> snapshot) {
  if (snapshot.hasError) {
    return const Text('Error');
  } else if (snapshot.hasData) {
    if (snapshot.data == true) {
      return const SettingWidget();
    } else {
      return const LoginWidget();
    }
  } else {
    return const Text('');
  }
}
