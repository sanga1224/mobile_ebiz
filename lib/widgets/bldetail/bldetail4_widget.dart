import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/bldetail/bl_freight.dart';
import 'package:mobile_ebiz/models/bldetail/bldetail.dart';

class BLDetail4Widget extends StatelessWidget {
  const BLDetail4Widget({super.key, required this.blno, required this.blInfo});
  final String blno;
  final BLDetail blInfo;

  @override
  Widget build(BuildContext context) {
    List<Widget> getFreight() {
      num usdamt = 0, locamt = 0;
      var format = NumberFormat('###,###,###,###');
      List<Widget> result = [];
      result.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 7,
              child: Text(
                'frtinit'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 7,
              child: Text(
                'cur'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 7,
              child: Text(
                'frtunit'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 2 / 7,
              child: Text(
                'usdamt'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 2 / 7,
              child: Text(
                'locamt'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      );

      for (BLFreight frt in blInfo.freights) {
        usdamt += num.parse(frt.usdAmt.replaceAll(",", ""));
        locamt += num.parse(frt.locAmt.replaceAll(",", ""));
        result.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 7,
                child: Text(
                  frt.init,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 7,
                child: Text(
                  frt.cur,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 7,
                child: Text(
                  frt.unit,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 2 / 7,
                child: Text(
                  frt.usdAmt,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 2 / 7,
                child: Text(
                  frt.locAmt,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ],
          ),
        );
      }
      result.add(
        Divider(
          color: Theme.of(context).colorScheme.outline,
          thickness: 1,
        ),
      );
      result.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 7,
              child: Text(
                '',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 7,
              child: Text(
                '',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 7,
              child: Text(
                '',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 2 / 7,
              child: Text(
                format.format(usdamt),
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 2 / 7,
              child: Text(
                format.format(locamt),
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ],
        ),
      );
      return result;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.monetization_on_outlined,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Freight',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.outline,
            thickness: 1,
          ),
          Container(
            clipBehavior: Clip.hardEdge, //Overflow 된 부분 잘라내기
            decoration: const BoxDecoration(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 15, right: 15, bottom: 0),
                child: Column(
                  children: getFreight(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
