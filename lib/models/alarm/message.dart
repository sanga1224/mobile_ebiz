class Message {
  final String title, contents, inpdate, blno;

  Message.fromJson(Map<String, dynamic> json)
      : title = json['title'].toString(),
        contents = json['contents'].toString(),
        inpdate = json['inpdate'].toString(),
        blno = json['blno'].toString();
}
