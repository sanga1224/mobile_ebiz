import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
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
                          decoration: InputDecoration(labelText: 'id'.tr()),
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
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
                          onPressed: () {},
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
