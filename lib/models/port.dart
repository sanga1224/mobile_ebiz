class Port {
  final String nation, nationnm, port, portnm, lat, lng;
  final int portorder;

  Port.fromJson(Map<String, dynamic> json)
      : nation = json['NATION'],
        nationnm = json['NATIONNM'],
        port = json['PORT'],
        portnm = json['PORTNM'].toString().substring(
            0,
            (json['PORTNM'].toString().contains(',')
                ? json['PORTNM'].toString().indexOf(',')
                : json['PORTNM'].toString().length)),
        portorder = json['PORTORDER'],
        lat = json['LAT'].toString(),
        lng = json['LNG'].toString();
}
