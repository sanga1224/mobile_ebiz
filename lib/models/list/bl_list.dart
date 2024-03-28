class BLList {
  String blno,
      vslcd,
      vslnm,
      vyg,
      pol,
      pod,
      cntr,
      dg,
      etd,
      eta,
      transit,
      pickupTransit,
      returnTransit;

  BLList.fromJson(Map<String, dynamic> json)
      : blno = json['blno'] ?? '',
        vslcd = json['vslcd'] ?? '',
        vslnm = json['vslnm'] ?? '',
        vyg = json['vyg'] ?? '',
        pol = json['pol'] ?? '',
        pod = json['pod'] ?? '',
        cntr = json['cntr'] ?? '',
        dg = json['dg'] ?? '',
        etd = json['etd'] ?? '',
        eta = json['eta'] ?? '',
        transit = json['transit'].toString(),
        pickupTransit = json['pickupTransit'].toString(),
        returnTransit = json['returnTransit'].toString();
}
