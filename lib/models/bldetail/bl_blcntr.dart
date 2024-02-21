class BLBlCntr {
  int seq, pkg, vgm;
  String cntrNo, tpsz, sealNo, soc, vgmType, vgmSign, vgmCert;
  double wgt, cbm;

  BLBlCntr.fromJson(Map<String, dynamic> json)
      : seq = json['seq'],
        tpsz = json['tpsz'] ?? '',
        cntrNo = json['cntrNo'] ?? '',
        sealNo = json['sealNo'] ?? '',
        soc = json['soc'] ?? '',
        pkg = json['pkg'],
        wgt = json['wgt'],
        cbm = json['cbm'],
        vgm = json['vgm'],
        vgmType = json['vgmType'] ?? '',
        vgmSign = json['vgmSign'] ?? '',
        vgmCert = json['vgmCert'] ?? '';
}
