import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/schedule/schedule.dart';
import 'package:mobile_ebiz/models/schedule/schedule_detail.dart';

class ScheduleList extends StatelessWidget {
  final Schedule schedule;
  const ScheduleList({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    List<Widget> popupButtons(String avail) {
      List<Widget> lst = [];
      if (avail == 'Y') {
        lst.add(TextButton(
            onPressed: () {},
            child: Text(
              'booking'.tr(),
              style: Theme.of(context).textTheme.displayMedium,
            )));
      }
      lst.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'close'.tr(),
            style: Theme.of(context).textTheme.displayMedium,
          )));
      return lst;
    }

    List<Widget> vesselInfo() {
      List<Widget> result = [];
      int i = 0;
      for (ScheduleDetail vslinfo in schedule.vesselInformation) {
        result.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                vslinfo.voyageNumber == ''
                    ? vslinfo.vesselName
                    : '${vslinfo.vesselName} / ${vslinfo.voyageNumber}',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Flexible(
                child: i == 0
                    ? Text(
                        schedule.availableForBooking == 'Y'
                            ? 'avail_booking'.tr()
                            : 'inavail_booking'.tr(),
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .fontSize,
                          color: schedule.availableForBooking == 'Y'
                              ? Colors.blueAccent
                              : Colors.redAccent,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    : const Text(''),
              )
            ],
          ),
        );
        result.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                vslinfo.departureDate,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                vslinfo.arrivalDate,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        );
        i++;
      }
      return result;
    }

    List<Widget> getPopupContents() {
      bool displayDetail = false;
      List<Widget> result = [];
      int i = 0;
      for (ScheduleDetail vslinfo in schedule.vesselInformation) {
        if (vslinfo.vesselCode == '') {
          result.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    vslinfo.vesselName,
                    style: Theme.of(context).textTheme.displayMedium,
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
                  '${vslinfo.loadingPortCode}   ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  '-',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          );
          result.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${vslinfo.dischargingPortCode}   ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  '-',
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
                Flexible(
                  child: Text(
                    '${vslinfo.vesselName} / ${vslinfo.voyageNumber}',
                    style: Theme.of(context).textTheme.displayMedium,
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
                  '${vslinfo.loadingPortCode}   ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  vslinfo.departureDate,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          );
          result.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${vslinfo.dischargingPortCode}   ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  vslinfo.arrivalDate,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          );
          if (displayDetail == false) {
            result.add(
              const SizedBox(
                height: 10,
              ),
            );
            result.add(
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  '${'l_tml'.tr()}   ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Flexible(
                  child: Text(
                    vslinfo.loadingTerminalName,
                    style: Theme.of(context).textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),
            );
            result.add(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${'d_tml'.tr()}   ',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Flexible(
                    child: Text(
                      vslinfo.dischargingTerminalName,
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
                    '${'docu_cut'.tr()} ',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    schedule.documentCutOffTime,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            );
            result.add(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${'cntr_cut'.tr()} ',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    schedule.cargoCutOffTime,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            );
            result.add(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${'callsgn'.tr()} ',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    schedule.callSign,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            );
            result.add(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'MRN ',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    schedule.mrn,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            );
            result.add(
              const SizedBox(
                height: 10,
              ),
            );
            displayDetail = true;
          }
        }
        if (i < schedule.vesselInformation.length - 1) {
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

    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: true,
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
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.outline),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: getPopupContents(),
                      ),
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
            children: vesselInfo(),
          ),
        ),
      ),
    );
  }
}
