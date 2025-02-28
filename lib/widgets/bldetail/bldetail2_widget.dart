import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/bl/bldetail.dart';

class BLDetail2Widget extends StatelessWidget {
  const BLDetail2Widget({super.key, required this.blno, required this.blInfo});
  final String blno;
  final BLDetail blInfo;

  @override
  Widget build(BuildContext context) {
    List<Widget> getHeulier() {
      List<Widget> result = [];
      if (blInfo.selfTrans == 'Y') {
        result.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'pickupArea'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Flexible(
                child: Text(
                  blInfo.pickupArea,
                  style: Theme.of(context).textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                'pickupDate'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Flexible(
                child: Text(
                  blInfo.pickupDate,
                  style: Theme.of(context).textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
        result.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'heulier'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  blInfo.selfTransNm,
                  style: Theme.of(context).textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
        if (blInfo.selfTransPic != '') {
          result.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'pic'.tr(),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    '${blInfo.selfTransPic} [Tel.]${blInfo.selfTransTel}',
                    style: Theme.of(context).textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }
      } else if (blInfo.cfs == 'Y') {
        result.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'CFS',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  blInfo.cfsNm,
                  style: Theme.of(context).textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
        result.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'cfsPaid'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                blInfo.cfsPaid,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                'cfsDate'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                blInfo.cfsDate,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        );
      } else {
        result.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'factory'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  blInfo.factoryNm,
                  style: Theme.of(context).textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
        result.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'area'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Flexible(
                child: Text(
                  blInfo.factoryArea,
                  style: Theme.of(context).textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                'jobDate'.tr(),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Flexible(
                child: Text(
                  blInfo.lineTransDate,
                  style: Theme.of(context).textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
        if (blInfo.lineTransPic != '') {
          result.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'pic'.tr(),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    '${blInfo.lineTransPic} [Tel.]${blInfo.lineTransTel}',
                    style: Theme.of(context).textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }
      }
      result.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'returnArea'.tr(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                blInfo.lWharfNm,
                style: Theme.of(context).textTheme.displaySmall,
                overflow: TextOverflow.ellipsis,
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
              padding:
                  const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),
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
                      Flexible(
                        child: Text(
                          blInfo.forwarder,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                      Flexible(
                        child: Text(
                          blInfo.orgShipper,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                      Flexible(
                        child: Text(
                          '${blInfo.vslNm}/${blInfo.vyg}',
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                        Flexible(
                          child: Text(
                            blInfo.porNm,
                            style: Theme.of(context).textTheme.displaySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                      Flexible(
                        child: Text(
                          blInfo.polNm,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                      Flexible(
                        child: Text(
                          blInfo.podNm,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                      Flexible(
                        child: Text(
                          blInfo.dlvNm,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                        Flexible(
                          child: Text(
                            blInfo.fdNm,
                            style: Theme.of(context).textTheme.displaySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                      Flexible(
                        child: Text(
                          blInfo.freightTerm,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                      Flexible(
                        child: Text(
                          blInfo.mainItem == ''
                              ? blInfo.commodity
                              : blInfo.mainItem,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                        Flexible(
                          child: Text(
                            blInfo.say,
                            style: Theme.of(context).textTheme.displaySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                        Flexible(
                          child: Text(
                            blInfo.blType,
                            style: Theme.of(context).textTheme.displaySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          'cargoType'.tr(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Flexible(
                          child: Text(
                            blInfo.cargoType,
                            style: Theme.of(context).textTheme.displaySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          'Term',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Flexible(
                          child: Text(
                            blInfo.cargoTerm,
                            style: Theme.of(context).textTheme.displaySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                      Flexible(
                        child: Text(
                          blInfo.pkg,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        'WGT',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Flexible(
                        child: Text(
                          blInfo.wgt,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        'CBM',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Flexible(
                        child: Text(
                          blInfo.cbm,
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
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
          if (blInfo.polCd.substring(0, 2) == 'KR' && blInfo.userNacd == 'KR')
            Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.local_shipping_outlined,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'heulierInfo'.tr(),
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
                        top: 0, left: 15, right: 15, bottom: 0),
                    child: Column(
                      children: getHeulier(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          if (blInfo.shipperNm != '')
            Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person_outlined,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      blInfo.afrSnaNm == ''
                          ? 'Shipper'
                          : 'Shipper (${blInfo.afrSnaNm})',
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
                        top: 0, left: 15, right: 15, bottom: 0),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                blInfo.shipperNm.replaceAll('\\n', '\n'),
                                style: Theme.of(context).textTheme.displaySmall,
                                maxLines: 6,
                              ),
                            ],
                          ),
                        ),
                        if (blInfo.afrStel != '')
                          Divider(
                            color: Theme.of(context).colorScheme.outline,
                            thickness: 1,
                          ),
                        if (blInfo.afrStel != '')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'TEL',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                blInfo.afrStel,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        if (blInfo.afrSregNo != '')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'PAN',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                blInfo.afrSregNo,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        if (blInfo.afrSzipCode != '')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'POST',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                blInfo.afrSzipCode,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              Text(
                                'AMT',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                '${blInfo.afrSinvAmt} ${blInfo.afrSinvCur}',
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
          if (blInfo.consigneeNm != '')
            Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person_outlined,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      blInfo.afrCnaNm == ''
                          ? 'Consignee'
                          : 'Consignee (${blInfo.afrCnaNm})',
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
                        top: 0, left: 15, right: 15, bottom: 0),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                blInfo.consigneeNm.replaceAll('\\n', '\n'),
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        ),
                        if (blInfo.afrCtel != '')
                          Divider(
                            color: Theme.of(context).colorScheme.outline,
                            thickness: 1,
                          ),
                        if (blInfo.afrCtel != '')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'TEL',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                blInfo.afrCtel,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        if (blInfo.afrCregNo != '')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'PAN',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                blInfo.afrCregNo,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        if (blInfo.afrCpic != '')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'PIC',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                blInfo.afrCpic,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              Text(
                                'TEL',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                blInfo.afrCpicTel,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        if (blInfo.afrCzipCode != '')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'POST',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                blInfo.afrCzipCode,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              Text(
                                'ImpNo',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                blInfo.afrCimportNo,
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
          if (blInfo.notifyNm != '')
            Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person_outlined,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      blInfo.afrNnaNm == ''
                          ? 'Notify'
                          : 'Notify (${blInfo.afrNnaNm})',
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
                        top: 0, left: 15, right: 15, bottom: 0),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                blInfo.notifyNm.replaceAll('\\n', '\n'),
                                style: Theme.of(context).textTheme.displaySmall,
                                maxLines: 6,
                              ),
                            ],
                          ),
                        ),
                        if (blInfo.afrNtel != '')
                          Divider(
                            color: Theme.of(context).colorScheme.outline,
                            thickness: 1,
                          ),
                        if (blInfo.afrNtel != '')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'TEL',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                blInfo.afrNtel,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        if (blInfo.afrNregNo != '')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'PAN',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                blInfo.afrNregNo,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        if (blInfo.afrNzipCode != '')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'POST',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                blInfo.afrNzipCode,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              Text(
                                'ImpNo',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                blInfo.afrNimportNo,
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
          if (blInfo.marks.isNotEmpty)
            Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.event_note_outlined,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Mark',
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
                        top: 0, left: 15, right: 15, bottom: 0),
                    child: Column(children: [
                      for (var i = 0; i < blInfo.marks.length; i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              blInfo.marks[i].txt,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        ),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          if (blInfo.descs.isNotEmpty)
            Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.event_note_outlined,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Description',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < blInfo.descs.length; i++)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    blInfo.descs[i].txt,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ],
                              ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
