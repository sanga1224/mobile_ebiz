class Profile {
  String nickname, name, cellno, email, telno, faxno;
  int profile_seq, icon, maxseq;

  Profile.fromJson(Map<String, dynamic> json)
      : profile_seq = json['PROFILE_SEQ'],
        nickname = json['NICKNAME'].toString(),
        name = json['NAME'].toString(),
        cellno = json['CELLNO'] ?? '',
        email = json['EMAIL'] ?? '',
        telno = json['TELNO'] ?? '',
        faxno = json['FAXNO'] ?? '',
        icon = json['ICON'],
        maxseq = json['MAXSEQ'];
}
