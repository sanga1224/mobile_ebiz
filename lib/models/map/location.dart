class MapLocation {
  String code, name, message;
  int seq;
  double lat, lng, course;

  MapLocation.fromJson(Map<String, dynamic> json)
      : code = json['CODE'] ?? '',
        name = json['NAME'] ?? '',
        message = json['MESSAGE'] ?? '',
        seq = json['SEQ'],
        lat = json['LAT'],
        lng = json['LNG'],
        course = double.parse(json['COURSE'].toString());
}
