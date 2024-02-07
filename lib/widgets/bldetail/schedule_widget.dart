import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/bldetail/schedule.dart';

class BookingScheduleWidget extends StatelessWidget {
  const BookingScheduleWidget({super.key, required this.schedules});
  final List<BookingSchedule> schedules;

  @override
  Widget build(BuildContext context) {
    List<Widget> getSchedule() {
      List<Widget> result = [];
      int i = 0;

      for (BookingSchedule schedule in schedules) {
        result.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                schedule.vyg == ''
                    ? schedule.vslnm
                    : '${schedule.vslnm}/${schedule.vyg}',
                style: Theme.of(context).textTheme.displaySmall,
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
                  style: Theme.of(context).textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Text(
                  schedule.podnm,
                  style: Theme.of(context).textTheme.displaySmall,
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
        if (i < schedules.length - 1) {
          result.add(
            Divider(
              color: Theme.of(context).colorScheme.outline,
              thickness: 1,
            ),
          );
        }
      }
      return result;
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(children: getSchedule()),
    );
  }
}
