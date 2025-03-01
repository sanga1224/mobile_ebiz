import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/common_function.dart';
import 'package:mobile_ebiz/services/api_bl.dart';
import 'package:mobile_ebiz/widgets/bldetail/bldetail_main_widget.dart';

class SearchBlNoWidget extends StatelessWidget {
  const SearchBlNoWidget(
      {super.key, required this.isLogin, required this.func});
  final bool isLogin;
  final Function func;

  @override
  Widget build(BuildContext context) {
    TextEditingController txtBlNo = TextEditingController();
    Future<Iterable<String>> blnoSuggestions(String searchValue) async {
      if (searchValue.length > 3 &&
          CommonFunction.isNumeric(searchValue) == true) {
        return await ApiBL.findBlNo(searchValue);
      } else if (searchValue.length > 11 &&
          CommonFunction.isNumeric(searchValue) == false) {
        return await ApiBL.findBlNo(searchValue);
      } else {
        return const Iterable<String>.empty();
      }
    }

    void goBL(String blno) {
      if (blno.length != 16) {
        CommonFunction.showSnackBar(context, 'Input_Right_BlNo'.tr(), false);
        return;
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SearchWidget(blno: blno)));
        func(blno);
      }
    }

    return isLogin
        ? Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) async {
              Iterable<String>? options =
                  await blnoSuggestions(textEditingValue.text);
              return options;
            },
            onSelected: (String selection) {
              goBL(selection.substring(0, 16));
            },
            fieldViewBuilder: (context, txtBlNo, focusNode, onFieldSubmitted) {
              return TextField(
                controller: txtBlNo,
                onChanged: (value) {
                  txtBlNo.text = txtBlNo.text.toUpperCase();
                },
                focusNode: focusNode,
                onTap: onFieldSubmitted,
                decoration: InputDecoration(
                  labelText: 'B/L No.',
                  suffix: InkWell(
                    child: const Icon(Icons.search),
                    onTap: () {
                      goBL(txtBlNo.text);
                    },
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
              );
            },
          )
        : TextField(
            controller: txtBlNo,
            onChanged: (value) {
              txtBlNo.text = txtBlNo.text.toUpperCase();
            },
            decoration: InputDecoration(
              labelText: 'B/L No.',
              suffix: InkWell(
                child: const Icon(Icons.search),
                onTap: () {
                  goBL(txtBlNo.text);
                },
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
          );
  }
}
