class BLBkCntr {
  int qty;
  String seq,
      tpsz,
      soc,
      empty,
      dg,
      rf,
      awk,
      unno,
      imdg,
      temp,
      cover,
      awk_x,
      awk_y,
      awk_z,
      dgMix,
      dgList,
      specialInfo;
  double wgt;

  BLBkCntr.fromJson(Map<String, dynamic> json)
      : seq = json['seq'] ?? '',
        tpsz = json['tpsz'] ?? '',
        qty = json['qty'],
        soc = json['soc'] ?? '',
        empty = json['empty'] ?? '',
        dg = json['dg'] ?? '',
        rf = json['rf'] ?? '',
        awk = json['awk'] ?? '',
        unno = json['unno'] ?? '',
        imdg = json['imdg'] ?? '',
        temp = json['temp'] ?? '',
        cover = json['cover'] ?? '',
        awk_x = json['awk_x'] ?? '',
        awk_y = json['awk_y'] ?? '',
        awk_z = json['awk_z'] ?? '',
        wgt = json['wgt'] ?? 0,
        dgMix = json['dgMix'] ?? '',
        dgList = json['dgList'] ?? '',
        specialInfo = json['specialInfo'] ?? '';
}
