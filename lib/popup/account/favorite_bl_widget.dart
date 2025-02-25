import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/bl/favorite.dart';
import 'package:mobile_ebiz/models/common_function.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/services/api_bl.dart';

class FavoriteBLWidget extends StatefulWidget {
  const FavoriteBLWidget({super.key});

  @override
  State<FavoriteBLWidget> createState() => _FavoriteBLWidgetState();
}

class _FavoriteBLWidgetState extends State<FavoriteBLWidget> {
  Future<List<FavoriteBL>>? _myBL;
  List<TextEditingController> lstEditor = [];

  Future search() async {
    setState(() {
      _myBL = ApiBL.getFavorite();
    });
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
          StatusMsg result = await ApiBL.delFavorite(blno);
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

    Widget makeWidget(msg, blno) {
      TextEditingController ctrl = TextEditingController();
      ctrl.text = msg;
      lstEditor.add(ctrl);

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    delMyBL(blno);
                  },
                  child: const SizedBox(
                    width: 30,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ),
                Text(
                  '$blno',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 10,
                  child: Focus(
                    onFocusChange: ((value) {
                      if (!value && msg != ctrl.text) {
                        //lost focus
                        setState(() {
                          Future<StatusMsg> result =
                              ApiBL.addFavorite(blno, ctrl.text);
                          result.then((value) {
                            if (value.status == 'Y') {
                              search();
                              CommonFunction.showSnackBar(
                                  context, 'Save_Completed'.tr(), true);
                            }
                          });
                        });
                      }
                    }),
                    child: TextField(
                      controller: ctrl,
                      decoration: InputDecoration(
                        hintText: blno,
                        labelText: 'nickname'.tr(),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
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
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: FutureBuilder(
            future: _myBL,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Theme.of(context).colorScheme.outline,
                    size: 50,
                  ),
                );
              } else if (snapshot.hasData) {
                lstEditor.clear();

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return makeWidget(
                        snapshot.data![index].msg, snapshot.data![index].blno);
                  },
                );
              } else {
                return const Text('');
              }
            },
          ),
        ),
      ),
    );
  }
}
