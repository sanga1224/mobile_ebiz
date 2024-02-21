class BLMark {
  String seq, txt;

  BLMark.fromJson(Map<String, dynamic> json)
      : seq = json['seq'] ?? '',
        txt = json['txt'] ?? '';
}
