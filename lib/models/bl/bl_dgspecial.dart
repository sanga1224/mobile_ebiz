class BLDgSpecial {
  int cntrSeq, dgSeq, oPkg, iPkg;
  String unno,
      imdg,
      subRisk,
      pGrade,
      pollutant,
      limitedQty,
      sapt,
      technicalNm,
      contactNo,
      contactNm,
      remark,
      oPkgCd,
      oPkgNm,
      iPkgCd,
      iPkgNm,
      casNoList,
      isNeedFlashPoint,
      isNeedTechnicalNm,
      isNeedSapt,
      flashPoint,
      netWgt,
      grsWgt;

  BLDgSpecial.fromJson(Map<String, dynamic> json)
      : cntrSeq = json['cntrSeq'],
        dgSeq = json['dgSeq'],
        unno = json['unno'] ?? '',
        imdg = json['imdg'] ?? '',
        subRisk = json['subRisk'] ?? '',
        pGrade = json['pGrade'] ?? '',
        netWgt = json['netWgt'] == null ? '' : json['netWgt'].toString(),
        grsWgt = json['grsWgt'] == null ? '' : json['grsWgt'].toString(),
        pollutant = json['pollutant'] ?? '',
        limitedQty = json['limitedQty'] ?? '',
        flashPoint = json['flashPoint'] ?? '',
        sapt = json['sapt'] ?? '',
        technicalNm = json['technicalNm'] ?? '',
        contactNo = json['contactNo'] ?? '',
        contactNm = json['contactNm'] ?? '',
        remark = json['remark'] ?? '',
        oPkg = json['oPkg'],
        oPkgCd = json['oPkgCd'] ?? '',
        oPkgNm = json['oPkgNm'] ?? '',
        iPkg = json['iPkg'] ?? 0,
        iPkgCd = json['iPkgCd'] ?? '',
        iPkgNm = json['iPkgNm'] ?? '',
        casNoList = json['casNoList'] ?? '',
        isNeedFlashPoint = json['isNeedFlashPoint'] ?? '',
        isNeedTechnicalNm = json['isNeedTechnicalNm'] ?? '',
        isNeedSapt = json['isNeedSapt'] ?? '';
}
