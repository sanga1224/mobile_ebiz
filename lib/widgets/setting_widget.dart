import 'package:flutter/material.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: const CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('images/profiles/1.svg'),
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(width: 2, color: Colors.grey),
              //     color: Theme.of(context).colorScheme.background,
              //     shape: BoxShape.circle,
              //   ),
              //   child: const Icon(
              //     Icons.person,
              //     size: 50,
              //     color: Colors.grey,
              //   ),
              // ),
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: const Text(
                  'Roy',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: 200,
          height: 5,
          color: Colors.red,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextButton(
            onPressed: () {},
            child: Container(
              color: Colors.red,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '프로필 수정하기',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
