class Notice {
  String nacd, seq, title, inpdate;

  Notice.fromJson(Map<String, dynamic> json)
      : nacd = json['nacd'].toString(),
        seq = json['seq'].toString(),
        title = json['title'].toString(),
        inpdate = json['inpdate'].toString();
}
