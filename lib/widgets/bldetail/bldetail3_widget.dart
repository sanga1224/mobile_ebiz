import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/bl/bl_bkcntr.dart';
import 'package:mobile_ebiz/models/bl/bl_blcntr.dart';
import 'package:mobile_ebiz/models/bl/bl_dgspecial.dart';
import 'package:mobile_ebiz/models/bl/bldetail.dart';

class BLDetail3Widget extends StatelessWidget {
  const BLDetail3Widget({super.key, required this.blno, required this.blInfo});
  final String blno;
  final BLDetail blInfo;

  @override
  Widget build(BuildContext context) {
    List<Widget> getDgInfo(List<BLDgSpecial> dgSpecials, String seq) {
      List<Widget> result = [];
      int i = 0;
      for (BLDgSpecial dg in dgSpecials) {
        if (dg.cntrSeq == int.parse(seq)) {
          if (i > 0) {
            result.add(
              Divider(
                color: Theme.of(context).colorScheme.outline,
                thickness: 1,
              ),
            );
          }
          result.add(
            Row(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/dgs/${dg.imdg.replaceAll('.', '')}.gif',
                      width: 80,
                      height: 80,
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'UN/Cls',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${dg.unno}/${dg.imdg}',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'S.Risk/P.Grp',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${dg.subRisk}/${dg.pGrade}',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
          result.add(
            Row(
              children: [
                Text(
                  'GrsWgt/NetWgt',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${dg.grsWgt}/${dg.netWgt}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          );
          result.add(
            Row(
              children: [
                Text(
                  'Pollute/LimitQty',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${dg.pollutant}/${dg.limitedQty}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          );
          if (dg.flashPoint != '' || dg.sapt != '') {
            result.add(
              Row(
                children: [
                  Text(
                    dg.flashPoint != '' && dg.sapt != ''
                        ? 'F.Point/SAPT'
                        : dg.flashPoint != ''
                            ? 'F.Point'
                            : 'SAPT',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    dg.flashPoint != '' && dg.sapt != ''
                        ? '${dg.flashPoint}/${dg.sapt}'
                        : dg.flashPoint != ''
                            ? dg.flashPoint
                            : dg.sapt,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            );
          }
          if (dg.technicalNm != '') {
            result.add(
              Row(
                children: [
                  Text(
                    'Technical',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      dg.technicalNm,
                      style: Theme.of(context).textTheme.displaySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }
          result.add(
            Row(
              children: [
                Text(
                  'OutPKG',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${dg.oPkg} [${dg.oPkgCd}]',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          );
          if (dg.iPkgCd != '') {
            result.add(
              Row(
                children: [
                  Text(
                    'InPKG',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${dg.iPkg} [${dg.iPkgCd}]',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            );
          }
          result.add(
            Row(
              children: [
                Text(
                  'Contact',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    '${dg.contactNm} / ${dg.contactNo}',
                    style: Theme.of(context).textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
          i++;
        }
      }
      return result;
    }

    List<Widget> getCntrInfo(BLBlCntr cntr) {
      List<Widget> result = [];
      result.add(
        Row(
          children: [
            Text(
              'TPSZ',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              cntr.tpsz,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      );
      result.add(
        Row(
          children: [
            Text(
              'CNTR No.',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              cntr.cntrNo,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      );
      result.add(
        Row(
          children: [
            Text(
              'Seal No.',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              cntr.sealNo,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      );
      result.add(
        Row(
          children: [
            Text(
              'Owner',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              cntr.soc,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'PKG',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              cntr.pkg.toString(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      );
      result.add(
        Row(
          children: [
            Text(
              'WGT',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              cntr.wgt.toString(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'CBM',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              cntr.cbm.toString(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      );
      if (cntr.vgm != 0) {
        result.add(
          Row(
            children: [
              Text(
                'VGM',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                cntr.vgm.toString(),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'MSR',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  cntr.vgmType.toString(),
                  style: Theme.of(context).textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }
      if (cntr.vgmSign != '') {
        result.add(
          Row(
            children: [
              Text(
                'Sign',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                cntr.vgmSign,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        );
      }
      if (cntr.outDemLimit != '') {
        result.add(
          Row(
            children: [
              Text(
                'Freeday(Out)',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                cntr.outDemLimit,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        );
      }
      if (cntr.inDemLimit != '') {
        result.add(
          Row(
            children: [
              Text(
                'Freeday(In)',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                cntr.inDemLimit,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        );
      }
      return result;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.flip_to_front_outlined,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Container (Booking)',
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
                  for (BLBkCntr bkCntr in blInfo.bkCntrs)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Text(
                            '${bkCntr.tpsz} x ${bkCntr.qty}',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        if (bkCntr.dg == 'Y')
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    bottom: 0,
                                                    top: 20,
                                                    left: 20,
                                                    right: 20),
                                            actionsPadding: EdgeInsets.zero,
                                            content: SizedBox(
                                              height: 210,
                                              child: Container(
                                                padding: EdgeInsets.zero,
                                                clipBehavior: Clip
                                                    .hardEdge, //Overflow 된 부분 잘라내기
                                                decoration:
                                                    const BoxDecoration(),
                                                child: Flexible(
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: getDgInfo(
                                                        blInfo.dgSpecials,
                                                        bkCntr.seq,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'close'.tr(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                ),
                                              ),
                                            ]);
                                      });
                                },
                                child: const Text(
                                  'DG',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            bkCntr.specialInfo,
                            style: Theme.of(context).textTheme.displaySmall,
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
          if (blInfo.blCntrs.isNotEmpty)
            Column(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge, //Overflow 된 부분 잘라내기
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 15, right: 15, bottom: 0),
                    child: Column(
                      children: [
                        for (BLBlCntr blCntr in blInfo.blCntrs)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                blCntr.tpsz,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              Text(
                                blCntr.cntrNo,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              Text(
                                blCntr.soc,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    bottom: 0,
                                                    top: 20,
                                                    left: 20,
                                                    right: 20),
                                            actionsPadding: EdgeInsets.zero,
                                            content: SizedBox(
                                              height: 210,
                                              child: Container(
                                                padding: EdgeInsets.zero,
                                                clipBehavior: Clip
                                                    .hardEdge, //Overflow 된 부분 잘라내기
                                                decoration:
                                                    const BoxDecoration(),
                                                child: Column(children: [
                                                  Flexible(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: getCntrInfo(
                                                          blCntr,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'close'.tr(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                ),
                                              ),
                                            ]);
                                      });
                                },
                                child: Text(
                                  'details'.tr(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
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
