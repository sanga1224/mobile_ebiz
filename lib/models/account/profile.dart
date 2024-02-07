class Profile {
  String nickname, name, cellno, email, telno, faxno;
  int seq, icon, maxseq;

  Profile.fromJson(Map<String, dynamic> json)
      : seq = json['SEQ'],
        nickname = json['NICKNAME'].toString(),
        name = json['NAME'].toString(),
        cellno = json['CELLNO'] ?? '',
        email = json['EMAIL'] ?? '',
        telno = json['TELNO'] ?? '',
        faxno = json['FAXNO'] ?? '',
        icon = json['ICON'],
        maxseq = json['MAXSEQ'];
}
