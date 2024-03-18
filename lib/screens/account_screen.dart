import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/services/api_login.dart';
import 'package:mobile_ebiz/widgets/account/login_widget.dart';
import 'package:mobile_ebiz/widgets/account/myinfo_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key, required this.returnPage});
  final String returnPage;

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
          return _loadingWidget(snapshot, returnPage);
        },
      ),
    );
  }
}

Widget _loadingWidget(AsyncSnapshot<Object?> snapshot, String returnPage) {
  if (snapshot.hasError) {
    return const Text('Error');
  } else if (snapshot.hasData) {
    if (snapshot.data == true) {
      return const MyInfoWidget();
    } else {
      return LoginWidget(returnPage: returnPage);
    }
  } else {
    return const Text('');
  }
}
