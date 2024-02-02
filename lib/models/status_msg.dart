class StatusMsg {
  final String status, msg;

  StatusMsg.fromJson(Map<String, dynamic> json)
      : status = json['STATUS'],
        msg = json['MSG'] ?? '';
}
