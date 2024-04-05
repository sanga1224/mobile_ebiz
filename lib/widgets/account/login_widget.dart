import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/screens/main_screen.dart';
import 'package:mobile_ebiz/services/api_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key, required this.returnPage});
  final String returnPage;

  @override
  Widget build(BuildContext context) {
    void showSnackBar(BuildContext context, Text text) {
      final snackBar = SnackBar(
        content: text,
        backgroundColor: const Color.fromARGB(255, 112, 48, 48),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Future login(String userid, String pwd) async {
      if (userid == '' || pwd == '') {
        showSnackBar(context, Text('Input_ID_PWD'.tr()));
      }
      StatusMsg result = await ApiLogIn.getLogIn(userid.toUpperCase(), pwd);
      if (!context.mounted) {
        return result; //async-await gap 때문에 context가 null일 수 있어 추가 필요.
      }
      if (result.status == 'N') {
        showSnackBar(context, Text("Login_${result.msg}".tr()));
      } else {
        List<String> resultInfo = result.msg.split('|');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userNacd', resultInfo[0]);
        await prefs.setString('login_token', resultInfo[1]);
        await ApiLogIn.getProfile(0);
        if (!context.mounted) {
          return result; //async-await gap 때문에 context가 null일 수 있어 추가 필요.
        }
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => const MainScreen()));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => MainScreen(
                    forceIndex: (returnPage == 'Main' ? 2 : 1),
                  )),
        );
      }
    }

    TextEditingController txtUserId = TextEditingController();
    TextEditingController txtPwd = TextEditingController();
    // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
    // SingleChildScrollView으로 감싸 줌
    return GestureDetector(
      onTap: () {
        //입력하는 부분을 제외한 화면을 탭하면 키보드 사라지도록
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey),
                  color: Theme.of(context).colorScheme.background,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 150,
                  color: Colors.grey,
                ),
              ),
            ),
            Form(
              child: Theme(
                data: ThemeData(
                  primaryColor: Colors.grey,
                  inputDecorationTheme: Theme.of(context).inputDecorationTheme,
                ),
                child: Container(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        TextField(
                          controller: txtUserId,
                          decoration: InputDecoration(labelText: 'id'.tr()),
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: txtPwd,
                          decoration:
                              InputDecoration(labelText: 'password'.tr()),
                          keyboardType: TextInputType.text,
                          style: Theme.of(context).textTheme.bodySmall,
                          obscureText: true, // 비밀번호 안보이도록 하는 것
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await login(txtUserId.text, txtPwd.text);
                          },
                          style: Theme.of(context).elevatedButtonTheme.style,
                          icon: const Icon(Icons.lock_outline),
                          label: Text('login'.tr()),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
