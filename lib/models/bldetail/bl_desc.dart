class BLDesc {
  int seq;
  String txt;

  BLDesc.fromJson(Map<String, dynamic> json)
      : seq = json['seq'],
        txt = json['txt'] ?? '';
}
