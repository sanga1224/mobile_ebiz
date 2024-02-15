import 'package:mobile_ebiz/models/map/location.dart';
import 'package:mobile_ebiz/models/map/path.dart';

class BLTrackingMap {
  List<MapLocation> locations = [];
  List<MapPath> paths = [];

  BLTrackingMap.fromJson(Map<String, dynamic> json)
      : locations = (json['location'] as List)
            .map((i) => MapLocation.fromJson(i))
            .toList(),
        paths = (json['path'] as List).map((i) => MapPath.fromJson(i)).toList();
}
