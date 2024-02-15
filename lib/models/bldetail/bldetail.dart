import 'package:mobile_ebiz/models/bldetail/bl_schedule.dart';
import 'package:mobile_ebiz/models/bldetail/bl_tracking.dart';

class BLDetail {
  List<BLSchedule> schedules = [];
  List<BLTracking> trackings = [];

  BLDetail.fromJson(Map<String, dynamic> json)
      : schedules = (json['schedules'] as List)
            .map((i) => BLSchedule.fromJson(i))
            .toList(),
        trackings = (json['trackings'] as List)
            .map((i) => BLTracking.fromJson(i))
            .toList();
}
