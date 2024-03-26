class Notice {
  String seq, title, inpdate;

  Notice.fromJson(Map<String, dynamic> json)
      : seq = json['seq'].toString(),
        title = json['title'].toString(),
        inpdate = json['inpdate'].toString();
}
