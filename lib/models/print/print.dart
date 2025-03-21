class Print {
  String status, compcd, div, bkno, pid, na, seq, msg;

  Print.fromJson(Map<String, dynamic> json)
      : status = json['STATUS'] ?? '',
        compcd = json['COMPCD'] ?? '',
        div = json['DIV'] ?? '',
        bkno = json['BKNO'] ?? '',
        pid = json['PID'] ?? '',
        na = json['NA'] ?? '',
        seq = json['SEQ'] ?? '',
        msg = json['MSG'] ?? '';
}
