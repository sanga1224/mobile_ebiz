import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/bl/recent.dart';
import 'package:mobile_ebiz/models/common_function.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/services/api_bl.dart';

class RecentBLWidget extends StatefulWidget {
  const RecentBLWidget({super.key});

  @override
  State<RecentBLWidget> createState() => _RecentBLWidgetState();
}

class _RecentBLWidgetState extends State<RecentBLWidget> {
  Future<List<RecentBL>>? _recentBL;

  Future search() async {
    setState(() {
      _recentBL = ApiBL.getRecentBL();
    });
  }

  void delRecentBL(String blno) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      title: '',
      text: 'delete?'.tr(),
      confirmBtnText: 'yes'.tr(),
      cancelBtnText: 'no'.tr(),
      onConfirmBtnTap: () {
        Future<StatusMsg> status = ApiBL.delRecentBL(blno);
        status.then((value) {
          if (value.status == 'Y') {
            search();
            CommonFunction.showSnackBar(context, 'Delete_Completed'.tr(), true);
          } else {
            CommonFunction.showSnackBar(context, 'Error_Occured'.tr(), false);
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    search();
  }

  @override
  Widget build(BuildContext context) {
    void delMyBL(String blno) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        title: '',
        text: 'delete?'.tr(),
        confirmBtnText: 'yes'.tr(),
        cancelBtnText: 'no'.tr(),
        onConfirmBtnTap: () async {
          StatusMsg result = await ApiBL.delRecentBL(blno);
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

    return GestureDetector(
      //Focus out을 위한 detector
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'mybl'.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: _recentBL,
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
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data![index].blno,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        delMyBL(snapshot.data![index].blno);
                                      },
                                      child: SizedBox(
                                        width: 30,
                                        child: Icon(
                                          Icons.close_outlined,
                                          color: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
            ElevatedButton.icon(
              onPressed: () {
                delRecentBL('');
              },
              icon: const Icon(Icons.delete_outline),
              label: Text('Delete_All'.tr()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
