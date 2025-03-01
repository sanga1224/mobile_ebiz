class BLNoList {
  String gb, blno, refno, polcd, podcd, custcd;

  BLNoList.fromJson(Map<String, dynamic> json)
      : gb = json['GB'] ?? '',
        blno = json['BLNO'] ?? '',
        refno = json['REFNO'] ?? '',
        polcd = json['POLCD'] ?? '',
        podcd = json['PODCD'] ?? '',
        custcd = json['CUSTCD'] ?? '';
}
