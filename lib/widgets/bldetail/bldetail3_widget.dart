import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/bldetail/bl_bkcntr.dart';
import 'package:mobile_ebiz/models/bldetail/bl_blcntr.dart';
import 'package:mobile_ebiz/models/bldetail/bldetail.dart';

class BLDetail3Widget extends StatelessWidget {
  const BLDetail3Widget({super.key, required this.blno, required this.blInfo});
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
                                onPressed: () {},
                                child: Text(
                                  'D/G',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
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
                Row(
                  children: [
                    const Icon(
                      Icons.flip_to_front_outlined,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Container (B/L)',
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
                                onPressed: () {},
                                child: Text(
                                  'View',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
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
