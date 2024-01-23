import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/schedule.dart';

class ScheduleList extends StatelessWidget {
  final Schedule schedule;
  const ScheduleList({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    List<Widget> popupButtons(String avail) {
      List<Widget> lst = [];
      if (avail == 'Y') {
        lst.add(TextButton(onPressed: () {}, child: const Text('예약')));
      }
      lst.add(TextButton(onPressed: () {}, child: const Text('취소')));
      return lst;
    }

    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext ctx) {
              return AlertDialog(
                contentPadding: const EdgeInsets.only(
                    bottom: 0, top: 20, left: 20, right: 20),
                actionsPadding: EdgeInsets.zero,
                content: SizedBox(
                  height: 210,
                  child: Container(
                    padding: EdgeInsets.zero,
                    clipBehavior: Clip.hardEdge, //Overflow 된 부분 잘라내기
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.outline),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${schedule.vesselInformation[0].vesselName} / ${schedule.vesselInformation[0].voyageNumber}',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Row(
                              children: [
                                Text(
                                  'ETD : ',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                Text(
                                  schedule.vesselInformation[0].departureDate,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'ETA : ',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                Text(
                                  schedule.vesselInformation[0].arrivalDate,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 1.0,
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                ),
                              ),
                              child: Row(children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'L.Terminal : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      'D.Terminal : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      '서류마감 : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      '반입마감 : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      'Call Sign : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      'MRN : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      schedule.vesselInformation[0]
                                          .loadingTerminalName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      schedule.vesselInformation[0]
                                          .dischargingTerminalName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      schedule.documentCutOffTime,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      schedule.cargoCutOffTime,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      schedule.callSign,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      schedule.mrn,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                actions: popupButtons(schedule.availableForBooking),
              );
            });
      },
      child: Container(
        clipBehavior: Clip.hardEdge, //Overflow 된 부분 잘라내기
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1.0,
          color: Theme.of(context).colorScheme.outline,
        ))),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${schedule.vesselInformation[0].vesselName} / ${schedule.vesselInformation[0].voyageNumber}',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    schedule.availableForBooking == 'Y' ? '예약가능' : '예약불가',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.displaySmall!.fontSize,
                      color: schedule.availableForBooking == 'Y'
                          ? Colors.blueAccent
                          : Colors.redAccent,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    schedule.vesselInformation[0].departureDate,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    schedule.vesselInformation[0].arrivalDate,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
