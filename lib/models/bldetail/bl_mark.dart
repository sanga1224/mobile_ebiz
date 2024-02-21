class BLMark {
  int seq;
  String txt;

  BLMark.fromJson(Map<String, dynamic> json)
      : seq = json['seq'],
        txt = json['txt'] ?? '';
}
