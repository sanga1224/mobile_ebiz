import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/services/api_login.dart';

class ProfileAdd extends StatefulWidget {
  const ProfileAdd(
      {super.key,
      required this.seq,
      required this.icon,
      required this.nickName,
      required this.name,
      required this.cellno,
      required this.email,
      required this.telno,
      required this.faxno,
      required this.func});
  final int seq, icon;
  final String nickName, name, cellno, email, telno, faxno;
  final Function func;

  @override
  State<ProfileAdd> createState() => _ProfileAddState();
}

class _ProfileAddState extends State<ProfileAdd> {
  int iconSeq = 0;
  TextEditingController txtNickName = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtCellNo = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtTelNo = TextEditingController();
  TextEditingController txtFaxNo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (iconSeq == 0) {
      txtNickName = TextEditingController(text: widget.nickName);
      txtName = TextEditingController(text: widget.name);
      txtCellNo = TextEditingController(text: widget.cellno);
      txtEmail = TextEditingController(text: widget.email);
      txtTelNo = TextEditingController(text: widget.telno);
      txtFaxNo = TextEditingController(text: widget.faxno);
    }
    if (iconSeq == 0) {
      iconSeq = widget.icon == 0 ? 1 : widget.icon;
    }

    void showSnackBar(BuildContext context, Text text) {
      final snackBar = SnackBar(
        content: text,
        backgroundColor: const Color.fromARGB(255, 112, 48, 48),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Future save() async {
      debugPrint('save');
      if (txtNickName.text == '') {
        showSnackBar(context, Text('Input_NickName'.tr()));
      } else if (txtName.text == '') {
        showSnackBar(context, Text('Input_Name'.tr()));
      } else if (txtEmail.text == '') {
        showSnackBar(context, Text('Input_Email'.tr()));
      } else if (RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(txtEmail.text) ==
          false) {
        showSnackBar(context, Text('InValid_Email'.tr()));
      } else if (txtTelNo.text == '') {
        showSnackBar(context, Text('Input_TelNo'.tr()));
      } else {
        StatusMsg result = await ApiLogIn.saveProfile(
            widget.seq,
            iconSeq,
            txtNickName.text,
            txtName.text,
            txtCellNo.text,
            txtEmail.text,
            txtTelNo.text,
            txtFaxNo.text);
        if (!context.mounted) {
          return result; //async-await gap 때문에 context가 null일 수 있어 추가 필요.
        }
        if (result.status == 'N') {
          showSnackBar(context, Text("ProfileAdd_Error".tr()));
        } else {
          if (!context.mounted) {
            return result; //async-await gap 때문에 context가 null일 수 있어 추가 필요.
          }
          widget.func(int.parse(result.msg));
          showSnackBar(context, Text('Save_Completed'.tr()));
          Navigator.pop(context);
        }
      }
    }

    void prevImage(curSeq) {
      setState(() {
        iconSeq = curSeq - 1;
      });
    }

    void nextImage(curSeq) {
      setState(() {
        iconSeq = curSeq + 1;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (widget.seq == 0 ? '${'new'.tr()} ' : '') +
                  'profile'.tr() +
                  (widget.seq == 0 ? '' : ' ${'revise'.tr()}'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            GestureDetector(
              onTap: save,
              child: const Icon(
                Icons.check_outlined,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  iconSeq == 1
                      ? const Text('           ')
                      : GestureDetector(
                          onTap: () {
                            prevImage(iconSeq);
                          },
                          child: const Icon(
                            Icons.chevron_left,
                            size: 40,
                          ),
                        ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
                      color: Theme.of(context).colorScheme.background,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/profiles/$iconSeq.svg',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  iconSeq == 18
                      ? const Text('           ')
                      : GestureDetector(
                          onTap: () {
                            nextImage(iconSeq);
                          },
                          child: const Icon(
                            Icons.chevron_right,
                            size: 40,
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.grey,
                    inputDecorationTheme:
                        Theme.of(context).inputDecorationTheme,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: txtNickName,
                          decoration:
                              InputDecoration(labelText: 'nickname'.tr()),
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: txtName,
                          decoration: InputDecoration(labelText: 'name'.tr()),
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: txtCellNo,
                          decoration: InputDecoration(labelText: 'cellno'.tr()),
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: txtEmail,
                          decoration: InputDecoration(labelText: 'email'.tr()),
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: txtTelNo,
                          decoration: InputDecoration(labelText: 'telno'.tr()),
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: txtFaxNo,
                          decoration: InputDecoration(labelText: 'faxno'.tr()),
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
