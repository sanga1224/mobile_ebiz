import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PercentIndicator extends StatelessWidget {
  const PercentIndicator(
      {super.key,
      required this.bound,
      required this.pickupTransit,
      required this.returnTransit,
      required this.transit});
  final String bound, pickupTransit, returnTransit, transit;

  @override
  Widget build(BuildContext context) {
    bool visible = bound == 'C' ? false : true;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LinearPercentIndicator(
          padding: const EdgeInsets.all(0),
          animation: false,
          width: bound == 'O'
              ? MediaQuery.of(context).size.width * 0.23
              : bound == 'I'
                  ? MediaQuery.of(context).size.width * 0.45
                  : MediaQuery.of(context).size.width * 0.91,
          lineHeight: 18,
          percent: bound == 'O'
              ? double.parse(pickupTransit)
              : double.parse(transit),
          center: Text(
            bound == 'O'
                ? '${'pickup'.tr()}(${(double.parse(pickupTransit) * 100).toStringAsFixed(0)}%)'
                : '${'sailing'.tr()}(${(double.parse(transit) * 100).toStringAsFixed(0)}%)',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          progressColor: Colors.green,
          backgroundColor: Colors.grey,
          barRadius: Radius.zero,
        ),
        Visibility(
          visible: visible,
          child: LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: false,
            width: MediaQuery.of(context).size.width * 0.23,
            lineHeight: 18,
            percent: bound == 'O'
                ? double.parse(returnTransit)
                : double.parse(pickupTransit),
            center: Text(
              bound == 'O'
                  ? '${'return'.tr()}(${(double.parse(returnTransit) * 100).toStringAsFixed(0)}%)'
                  : '${'pickup'.tr()}(${(double.parse(pickupTransit) * 100).toStringAsFixed(0)}%)',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            progressColor: Colors.green,
            backgroundColor: Colors.blueGrey,
            barRadius: Radius.zero,
          ),
        ),
        Visibility(
          visible: visible,
          child: LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: false,
            width: bound == 'O'
                ? MediaQuery.of(context).size.width * 0.45
                : MediaQuery.of(context).size.width * 0.23,
            lineHeight: 18,
            percent: bound == 'O'
                ? double.parse(transit)
                : double.parse(returnTransit),
            center: Text(
              bound == 'O'
                  ? '${'sailing'.tr()}(${(double.parse(transit) * 100).toStringAsFixed(0)}%)'
                  : '${'return'.tr()}(${(double.parse(returnTransit) * 100).toStringAsFixed(0)}%)',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            progressColor: Colors.green,
            backgroundColor: const Color.fromRGBO(97, 97, 119, 1),
            barRadius: Radius.zero,
          ),
        ),
      ],
    );
  }
}
