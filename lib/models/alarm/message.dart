class Message {
  final String refno, title, contents, inpdate, blno, read;

  Message.fromJson(Map<String, dynamic> json)
      : refno = json['refno'].toString(),
        title = json['title'].toString(),
        contents = json['contents'].toString(),
        inpdate = json['inpdate'].toString(),
        blno = json['blno'].toString(),
        read = json['read'].toString();
}
