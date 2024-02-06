import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  //Ticker가 필요한 애니메이션이 한개인 경우
  TextEditingController txtBlNo = TextEditingController();

  late TabController tabController = TabController(
    length: 3,
    vsync: this,
    initialIndex: 0,
    //탭 변경 애니메이션 시간
    animationDuration: const Duration(milliseconds: 800),
  );

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: TextField(
              controller: txtBlNo,
              decoration: InputDecoration(
                labelText: 'B/L No.',
                suffix: InkWell(
                  child: const Icon(Icons.search),
                  onTap: () {},
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              keyboardType: TextInputType.text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        TabBar(
          controller: tabController,
          labelStyle: Theme.of(context).textTheme.labelSmall,
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(fontSize: 15),
          overlayColor: MaterialStatePropertyAll(Theme.of(context)
              .colorScheme
              .primaryContainer), //탭바 클릭 시 나오는 splash effect 컬러
          splashBorderRadius:
              BorderRadius.circular(10), // 탭바 클릭할 때 나오는 splash effect의 radius
          tabs: [
            Tab(text: 'schedule'.tr()),
            Tab(text: 'detailinfo'.tr()),
            Tab(text: 'tracking'.tr()),
          ],
        ),
      ],
    );
  }
}
