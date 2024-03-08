class BLFreight {
  String init, name, cur, unit, usdAmt, locAmt;

  BLFreight.fromJson(Map<String, dynamic> json)
      : init = json['init'] ?? '',
        name = json['name'] ?? '',
        cur = json['cur'] ?? '',
        unit = json['unit'] ?? '',
        usdAmt = json['usdAmt'].toString(),
        locAmt = json['locAmt'].toString();
}
