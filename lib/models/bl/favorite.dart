class FavoriteBL {
  String blno, msg, cntr, pol, pod, vsl, vslnm, vyg;

  FavoriteBL.fromJson(Map<String, dynamic> json)
      : blno = json['BLNO'] ?? '',
        msg = json['MSG'] ?? '',
        cntr = json['CNTR'] ?? '',
        pol = json['POL'] ?? '',
        pod = json['POD'] ?? '',
        vsl = json['VSL'] ?? '',
        vslnm = json['VSLNM'] ?? '',
        vyg = json['VYG'] ?? '';
}
