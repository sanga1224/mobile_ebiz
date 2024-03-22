class BLBlCntr {
  int pkg, vgm, outDemBasic, outDemAdd, inDemBasic, inDemAdd;
  String seq, cntrNo, tpsz, sealNo, soc, vgmType, vgmSign, vgmCert;
  String outDemLimit, inDemLimit;
  double wgt, cbm;

  BLBlCntr.fromJson(Map<String, dynamic> json)
      : seq = json['seq'] ?? '',
        tpsz = json['sz'].toString() + json['tp'].toString(),
        cntrNo = json['cntrNo'] ?? '',
        sealNo = json['sealNo'] ?? '',
        soc = json['soc'] ?? '',
        pkg = json['pkg'],
        wgt = json['wgt'],
        cbm = json['cbm'],
        vgm = json['vgm'],
        vgmType = json['vgmType'] ?? '',
        vgmSign = json['vgmSign'] ?? '',
        vgmCert = json['vgmCert'] ?? '',
        outDemBasic = json['outDemBasic'] ?? 0,
        outDemAdd = json['outDemAdd'] ?? 0,
        outDemLimit = json['outDemLimit'] ?? '',
        inDemBasic = json['inDemBasic'] ?? 0,
        inDemAdd = json['inDemAdd'] ?? 0,
        inDemLimit = json['inDemLimit'] ?? '';
}
