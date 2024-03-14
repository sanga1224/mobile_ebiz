class BLList {
  String blno, vslcd, vslnm, vyg, pol, pod, cntr, transit, dg, etd, eta;

  BLList.fromJson(Map<String, dynamic> json)
      : blno = json['blno'] ?? '',
        vslcd = json['vslcd'] ?? '',
        vslnm = json['vslnm'] ?? '',
        vyg = json['vyg'] ?? '',
        pol = json['pol'] ?? '',
        pod = json['pod'] ?? '',
        cntr = json['cntr'] ?? '',
        transit = json['transit'].toString(),
        dg = json['dg'] ?? '',
        etd = json['etd'] ?? '',
        eta = json['eta'] ?? '';
}
