import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/bldetail/bldetail.dart';

class BLDetail2Widget extends StatelessWidget {
  const BLDetail2Widget({super.key, required this.blno, required this.blInfo});
  final String blno;
  final BLDetail blInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.text_snippet_outlined,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Cargo & Document',
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
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 0, left: 15, right: 15, bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'forwarder'.tr(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        blInfo.forwarder,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'orgShipper'.tr(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        blInfo.orgShipper,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'vslvyg'.tr(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${blInfo.vslNm}/${blInfo.vyg}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                  if (blInfo.porNm != '')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'receipt'.tr(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          blInfo.porNm,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'loading'.tr(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        blInfo.polNm,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'discharging'.tr(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        blInfo.podNm,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'delivery'.tr(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        blInfo.dlvNm,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                  if (blInfo.fdNm != '')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'finalDest'.tr(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          blInfo.fdNm,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Freight Term',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        blInfo.freightTerm,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        blInfo.mainItem == '' ? 'Commodity' : 'Main Item',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        blInfo.mainItem == ''
                            ? blInfo.commodity
                            : blInfo.mainItem,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                  if (blInfo.say != '')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Say',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          blInfo.say,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  if (blInfo.cargoType != '')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'B/L Type',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          blInfo.blType,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          'cargoType'.tr(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          blInfo.cargoType,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          'Term',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          blInfo.cargoTerm,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PKG',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        blInfo.pkg,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        'WGT',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        blInfo.wgt,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        'CBM',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        blInfo.cbm,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
