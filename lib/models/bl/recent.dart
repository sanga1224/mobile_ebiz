class RecentBL {
  String blno, cntr, pol, pod, vsl, vslnm, vyg;

  RecentBL.fromJson(Map<String, dynamic> json)
      : blno = json['BLNO'] ?? '',
        cntr = json['CNTR'] ?? '',
        pol = json['POL'] ?? '',
        pod = json['POD'] ?? '',
        vsl = json['VSL'] ?? '',
        vslnm = json['VSLNM'] ?? '',
        vyg = json['VYG'] ?? '';
}
