class BLDesc {
  String seq, txt;

  BLDesc.fromJson(Map<String, dynamic> json)
      : seq = json['seq'] ?? '',
        txt = json['txt'] ?? '';
}
