class BLTracking {
  String event, mv, unit, location, eventDate, eventTime;

  BLTracking.fromJson(Map<String, dynamic> json)
      : event = json['EVENT'] ?? '',
        mv = json['MV'] ?? '',
        unit = json['UNIT'] ?? '',
        location = json['LOCATION'] ?? '',
        eventDate = json['EVENTDATE'] ?? '',
        eventTime = json['EVENTTIME'] ?? '';
}
