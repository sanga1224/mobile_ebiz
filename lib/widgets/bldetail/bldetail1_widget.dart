import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/bl/bl_schedule.dart';
import 'package:mobile_ebiz/models/bl/bldetail.dart';
import 'package:mobile_ebiz/widgets/map/trackingmap_widget.dart';
import 'dart:math' as math;

class BLDetail1Widget extends StatelessWidget {
  const BLDetail1Widget({super.key, required this.blno, required this.blInfo});
  final String blno;
  final BLDetail blInfo;

  @override
  Widget build(BuildContext context) {
    List<Widget> getSchedule() {
      List<Widget> result = [];
      int i = 0;

      for (BLSchedule schedule in blInfo.schedules) {
        result.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                schedule.vyg == ''
                    ? schedule.vslnm
                    : '${schedule.vslnm}/${schedule.vyg}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        );
        result.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  schedule.polnm,
                  style: Theme.of(context).textTheme.displayMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Text(
                  schedule.podnm,
                  style: Theme.of(context).textTheme.displayMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
        if (schedule.vsl != '') {
          result.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    schedule.polwnm,
                    style: Theme.of(context).textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    schedule.podwnm,
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
                Flexible(
                  child: Text(
                    schedule.etd,
                    style: Theme.of(context).textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    schedule.eta,
                    style: Theme.of(context).textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }
        if (i < blInfo.schedules.length - 1) {
          result.add(
            Divider(
              color: Theme.of(context).colorScheme.outline,
              thickness: 1,
            ),
          );
        }
        i++;
      }
      return result;
    }

    Widget addResult(
        String event, String location, String datetime, List<Widget> popups) {
      return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    contentPadding: const EdgeInsets.only(
                        bottom: 0, top: 20, left: 20, right: 20),
                    actionsPadding: EdgeInsets.zero,
                    content: SizedBox(
                      height: 210,
                      child: Container(
                        padding: EdgeInsets.zero,
                        clipBehavior: Clip.hardEdge, //Overflow 된 부분 잘라내기
                        decoration: const BoxDecoration(
                            // border: Border(
                            //   top: BorderSide(
                            //       width: 1,
                            //       color: Theme.of(context).colorScheme.outline),
                            // ),
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: popups,
                                ),
                              ),
                            ),
                          ],
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
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ]);
              });
        },
        child: Container(
          clipBehavior: Clip.hardEdge, //Overflow 된 부분 잘라내기
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                event.contains('Pickup')
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: const Icon(
                          Icons.local_shipping_outlined,
                          size: 40,
                        ),
                      )
                    : event.contains('Departure')
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: const Icon(
                              Icons.sailing_outlined,
                              size: 40,
                            ),
                          )
                        : Icon(
                            event.contains('Return')
                                ? Icons.local_shipping_outlined
                                : event.contains('Arrival')
                                    ? Icons.sailing_outlined
                                    : Icons.local_shipping_outlined,
                            size: 40,
                          ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event,
                        style: Theme.of(context).textTheme.labelSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        location,
                        style: Theme.of(context).textTheme.displaySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        datetime,
                        style: Theme.of(context).textTheme.displaySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      // }
    }

    List<Widget> getTracking() {
      List<Widget> result = [];
      List<Widget> popups = [];
      String event = '', location = '', datetime = '';

      for (int i = 0; i <= blInfo.trackings.length; i++) {
        if (i == blInfo.trackings.length) {
          result.add(addResult(event, location, datetime, List.from(popups)));
          popups.clear();
        } else if (i == 0 || blInfo.trackings[i].event == event) {
          event = blInfo.trackings[i].event;
          location = blInfo.trackings[i].location;
          datetime =
              '${blInfo.trackings[i].eventDate.substring(0, blInfo.trackings[i].eventDate.indexOf(' '))} ${blInfo.trackings[i].eventTime}';
          if (popups.isEmpty == false) {
            popups.add(
              Divider(
                color: Theme.of(context).colorScheme.outline,
                thickness: 1,
              ),
            );
          }
          popups.add(
            const SizedBox(
              height: 5,
            ),
          );
          popups.add(
            Text(
              blInfo.trackings[i].unit,
              style: Theme.of(context).textTheme.labelSmall,
              overflow: TextOverflow.ellipsis,
            ),
          );
          popups.add(
            Text(
              location,
              style: Theme.of(context).textTheme.displaySmall,
              overflow: TextOverflow.ellipsis,
            ),
          );
          popups.add(
            Text(
              datetime,
              style: Theme.of(context).textTheme.displaySmall,
              overflow: TextOverflow.ellipsis,
            ),
          );
          popups.add(
            const SizedBox(
              height: 5,
            ),
          );
        } else if (blInfo.trackings[i].event != event) {
          result.add(addResult(event, location, datetime, List.from(popups)));
          popups.clear();
          event = blInfo.trackings[i].event;
          location = blInfo.trackings[i].location;
          datetime =
              '${blInfo.trackings[i].eventDate.substring(0, blInfo.trackings[i].eventDate.indexOf(' '))} ${blInfo.trackings[i].eventTime}';
          if (popups.isEmpty == false) {
            popups.add(
              Divider(
                color: Theme.of(context).colorScheme.outline,
                thickness: 1,
              ),
            );
          }
          popups.add(
            const SizedBox(
              height: 5,
            ),
          );
          popups.add(
            Text(
              blInfo.trackings[i].unit,
              style: Theme.of(context).textTheme.labelSmall,
              overflow: TextOverflow.ellipsis,
            ),
          );
          popups.add(
            Text(
              location,
              style: Theme.of(context).textTheme.displaySmall,
              overflow: TextOverflow.ellipsis,
            ),
          );
          popups.add(
            Text(
              datetime,
              style: Theme.of(context).textTheme.displaySmall,
              overflow: TextOverflow.ellipsis,
            ),
          );
          popups.add(
            const SizedBox(
              height: 5,
            ),
          );
        }
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
                Icons.directions_boat_outlined,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'schedule'.tr(),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getSchedule(),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (blInfo.blIssueType != '')
            Column(
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
                      'issuedInfo'.tr(),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'issuedType'.tr(),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                Text(
                                  'receiptType'.tr(),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  blInfo.blIssueType,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                Text(
                                  blInfo.blReceiptType,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'issuedDate'.tr(),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                Text(
                                  'On Board',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  blInfo.blIssueDate,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                Text(
                                  blInfo.onBoardDate,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
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
          if (blInfo.trackings.isNotEmpty)
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
                      'tracking'.tr(),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: getTracking(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          Row(
            children: [
              const Icon(
                Icons.map_outlined,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'map'.tr(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.outline,
            thickness: 1,
          ),
          TrackingMapWidget(
            blno: blno,
          ),
        ],
      ),
    );
  }
}
