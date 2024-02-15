class MapPath {
  String vslcd, vslnm, liner, nanm, imoNo, callSgn;
  double lat, lng;

  MapPath.fromJson(Map<String, dynamic> json)
      : vslcd = json['VSLCD'] ?? '',
        vslnm = json['VSLNM'] ?? '',
        liner = json['LINER'] ?? '',
        nanm = json['NANM'] ?? '',
        imoNo = json['IMONO'] ?? '',
        callSgn = json['CALLSGN'] ?? '',
        lat = json['LAT'],
        lng = json['LNG'];
}
