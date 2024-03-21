import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/common_function.dart';
import 'package:mobile_ebiz/models/schedule/myschedule.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/services/api_schedule.dart';

class FavoriteScheduleWidget extends StatefulWidget {
  const FavoriteScheduleWidget({super.key});

  @override
  State<FavoriteScheduleWidget> createState() => _FavoriteScheduleWidgetState();
}

class _FavoriteScheduleWidgetState extends State<FavoriteScheduleWidget> {
  Future<List<MySchedule>>? _mySchedule;

  Future search() async {
    setState(() {
      _mySchedule = ApiSchedule.getMySchedule();
    });
  }

  @override
  void initState() {
    super.initState();
    search();
  }

  @override
  Widget build(BuildContext context) {
    void delMySchedule(String pol, String pod) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        title: '',
        text: 'delete?'.tr(),
        confirmBtnText: 'yes'.tr(),
        cancelBtnText: 'no'.tr(),
        onConfirmBtnTap: () async {
          StatusMsg result = await ApiSchedule.delMySchedule(pol, pod);
          if (!context.mounted) {
            return; //async-await gap 때문에 context가 null일 수 있어 추가 필요.
          }
          if (result.status == 'Y') {
            CommonFunction.showSnackBar(context, 'Delete_Completed'.tr(), true);
            search();
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'myschedule'.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FutureBuilder(
          future: _mySchedule,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Theme.of(context).colorScheme.outline,
                  size: 50,
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                delMySchedule(snapshot.data![index].pol,
                                    snapshot.data![index].pod);
                              },
                              child: const SizedBox(
                                width: 40,
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Text(
                              '${snapshot.data![index].pol} -> ${snapshot.data![index].pod}',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Text('');
            }
          },
        ),
      ),
    );
  }
}
