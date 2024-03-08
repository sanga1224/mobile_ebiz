import 'package:mobile_ebiz/models/bldetail/bl_bkcntr.dart';
import 'package:mobile_ebiz/models/bldetail/bl_blcntr.dart';
import 'package:mobile_ebiz/models/bldetail/bl_desc.dart';
import 'package:mobile_ebiz/models/bldetail/bl_dgspecial.dart';
import 'package:mobile_ebiz/models/bldetail/bl_freight.dart';
import 'package:mobile_ebiz/models/bldetail/bl_mark.dart';
import 'package:mobile_ebiz/models/bldetail/bl_schedule.dart';
import 'package:mobile_ebiz/models/bldetail/bl_tracking.dart';

class BLDetail {
  String refNo,
      freightNo,
      commodity,
      commodityLocal,
      shipperRemark,
      linerRemark,
      forwarder,
      orgShipper,
      selfTrans,
      selfTransNm,
      pickupArea,
      pickupDate,
      selfTransPic,
      selfTransTel;
  String cfs,
      cfsNm,
      cfsPaid,
      cfsDate,
      lineTrans,
      factoryNm,
      factoryArea,
      lineTransDate,
      lineTransPic,
      lineTransTel,
      returnTml;
  String onBoardDate,
      blIssueDate,
      blIssueType,
      blIssueArea,
      blReceiptType,
      blReceiptArea,
      HHSTCD,
      HHSTNM,
      HHBJCD,
      HHBJNM,
      HHPASS_CD,
      HHPASS_NM;
  String lineTransNm,
      shipperNm,
      consigneeNm,
      notifyNm,
      vslCd,
      vslNm,
      vyg,
      porCd,
      porNm,
      polCd,
      polNm,
      podCd,
      podNm,
      dlvCd,
      dlvNm,
      fdCd,
      fdNm;
  String blType,
      cargoTerm,
      cargoType,
      freightTerm,
      pkg,
      wgt,
      cbm,
      mainItem,
      say,
      bkPicInfo,
      docuPicInfo,
      salesPicInfo,
      vslMainPicInfo,
      vslSubPicInfo,
      bkPicGender,
      docuPicGender,
      salesPicGender,
      vslMainPicGender,
      vslSubPicGender;
  String afrSnaCd,
      afrSnaNm,
      afrStel,
      afrSregType,
      afrSregNo,
      afrSexportNo,
      afrSgstNo,
      afrCnaCd,
      afrCnaNm,
      afrCtel,
      afrCregType,
      afrCregNo,
      afrCpic,
      afrCpicTel,
      afrCemail,
      afrScrap,
      afrCimportNo,
      afrCdepositNo,
      afrNnaCd,
      afrNnaNm,
      afrNtel,
      afrNregType,
      afrNregNo,
      afrNemail,
      afrSzipCode,
      afrScity,
      afrSinvCur,
      afrSinvAmt,
      afrCzipCode,
      afrCcity,
      afrCgstNo,
      afrNzipCode,
      afrNcity,
      afrNimportNo,
      afrNgstNo,
      qualifier,
      customsCode,
      docNo,
      docDate,
      userNacd,
      lWharfNm;
  List<BLSchedule> schedules = [];
  List<BLTracking> trackings = [];
  List<BLMark> marks = [];
  List<BLDesc> descs = [];
  List<BLBkCntr> bkCntrs = [];
  List<BLBlCntr> blCntrs = [];
  List<BLDgSpecial> dgSpecials = [];
  List<BLFreight> freights = [];

  BLDetail.fromJson(Map<String, dynamic> json)
      : refNo = json['refNo'] ?? '',
        freightNo = json['freightNo'] ?? '',
        commodity = json['commodity'] ?? '',
        commodityLocal = json['commodityLocal'] ?? '',
        shipperRemark = json['shipperRemark'] ?? '',
        linerRemark = json['linerRemark'] ?? '',
        forwarder = json['forwarder'] ?? '',
        orgShipper = json['orgShipper'] ?? '',
        selfTrans = json['selfTrans'] ?? '',
        selfTransNm = json['selfTransNm'] ?? '',
        pickupArea = json['pickupArea'] ?? '',
        pickupDate = json['pickupDate'] ?? '',
        selfTransPic = json['selfTransPic'] ?? '',
        selfTransTel = json['selfTransTel'] ?? '',
        cfs = json['cfs'] ?? '',
        cfsNm = json['cfsNm'] ?? '',
        cfsPaid = json['cfsPaid'] ?? '',
        cfsDate = json['cfsDate'] ?? '',
        lineTrans = json['lineTrans'] ?? '',
        factoryNm = json['factoryNm'] ?? '',
        factoryArea = json['factoryArea'] ?? '',
        lineTransDate = json['lineTransDate'] ?? '',
        lineTransPic = json['lineTransPic'] ?? '',
        lineTransTel = json['lineTransTel'] ?? '',
        returnTml = json['returnTml'] ?? '',
        onBoardDate = json['onBoardDate'] ?? '',
        blIssueDate = json['blIssueDate'] ?? '',
        blIssueType = json['blIssueType'] ?? '',
        blIssueArea = json['blIssueArea'] ?? '',
        blReceiptType = json['blReceiptType'] ?? '',
        blReceiptArea = json['blReceiptArea'] ?? '',
        HHSTCD = json['HHSTCD'] ?? '',
        HHSTNM = json['HHSTNM'] ?? '',
        HHBJCD = json['HHBJCD'] ?? '',
        HHBJNM = json['HHBJNM'] ?? '',
        HHPASS_CD = json['HHPASS_CD'] ?? '',
        HHPASS_NM = json['HHPASS_NM'] ?? '',
        lineTransNm = json['lineTransNm'] ?? '',
        shipperNm = json['shipperNm'] ?? '',
        consigneeNm = json['consigneeNm'] ?? '',
        notifyNm = json['notifyNm'] ?? '',
        vslCd = json['vslCd'] ?? '',
        vslNm = json['vslNm'] ?? '',
        vyg = json['vyg'] ?? '',
        porCd = json['porCd'] ?? '',
        porNm = json['porNm'] ?? '',
        polCd = json['polCd'] ?? '',
        polNm = json['polNm'] ?? '',
        podCd = json['podCd'] ?? '',
        podNm = json['podNm'] ?? '',
        dlvCd = json['dlvCd'] ?? '',
        dlvNm = json['dlvNm'] ?? '',
        fdCd = json['fdCd'] ?? '',
        fdNm = json['fdNm'] ?? '',
        blType = json['blType'] ?? '',
        cargoTerm = json['cargoTerm'] ?? '',
        cargoType = json['cargoType'] ?? '',
        freightTerm = json['freightTerm'] ?? '',
        pkg = json['pkg'] ?? '',
        wgt = json['wgt'] ?? '',
        cbm = json['cbm'] ?? '',
        mainItem = json['mainItem'] ?? '',
        say = json['say'] ?? '',
        bkPicGender = json['bkPicGender'],
        bkPicInfo = json['bkPicInfo'] ?? '',
        docuPicGender = json['docuPicGender'],
        docuPicInfo = json['docuPicInfo'] ?? '',
        salesPicGender = json['salesPicGender'] ?? '',
        salesPicInfo = json['salesPicInfo'] ?? '',
        vslMainPicGender = json['vslMainPicGender'] ?? '',
        vslMainPicInfo = json['vslMainPicInfo'] ?? '',
        vslSubPicGender = json['vslSubPicGender'] ?? '',
        vslSubPicInfo = json['vslSubPicInfo'] ?? '',
        afrSnaCd = json['afrSnaCd'] ?? '',
        afrSnaNm = json['afrSnaNm'] ?? '',
        afrStel = json['afrStel'] ?? '',
        afrSregType = json['afrSregType'] ?? '',
        afrSregNo = json['afrSregNo'] ?? '',
        afrSexportNo = json['afrSexportNo'] ?? '',
        afrSgstNo = json['afrSgstNo'] ?? '',
        afrCnaCd = json['afrCnaCd'] ?? '',
        afrCnaNm = json['afrCnaNm'] ?? '',
        afrCtel = json['afrCtel'] ?? '',
        afrCregType = json['afrCregType'] ?? '',
        afrCregNo = json['afrCregNo'] ?? '',
        afrCpic = json['afrCpic'] ?? '',
        afrCpicTel = json['afrCpicTel'] ?? '',
        afrCemail = json['afrCemail'] ?? '',
        afrScrap = json['afrScrap'] ?? '',
        afrCimportNo = json['afrCimportNo'] ?? '',
        afrCdepositNo = json['afrCdepositNo'] ?? '',
        afrNnaCd = json['afrNnacd'] ?? '',
        afrNnaNm = json['afrNnaNm'] ?? '',
        afrNtel = json['afrNtel'] ?? '',
        afrNregType = json['afrNregType'] ?? '',
        afrNregNo = json['afrNregNo'] ?? '',
        afrNemail = json['afrNemail'] ?? '',
        afrSzipCode = json['afrSzipCode'] ?? '',
        afrScity = json['afrScity'] ?? '',
        afrSinvCur = json['afrSinvCur'] ?? '',
        afrSinvAmt = json['afrSinvAmt'].toString() ?? '',
        afrCzipCode = json['afrCzipCode'] ?? '',
        afrCcity = json['afrCcity'] ?? '',
        afrCgstNo = json['afrCgstNo'] ?? '',
        afrNzipCode = json['afrNzipCode'] ?? '',
        afrNcity = json['afrNcity'] ?? '',
        afrNimportNo = json['afrNimportNo'] ?? '',
        afrNgstNo = json['afrNgstNo'] ?? '',
        qualifier = json['qualifier'] ?? '',
        customsCode = json['customsCode'] ?? '',
        docNo = json['docNo'] ?? '',
        docDate = json['docDate'] ?? '',
        userNacd = json['userNacd'] ?? '',
        lWharfNm = json['lWharfNm'] ?? '',
        schedules = (json['schedules'] as List)
            .map((i) => BLSchedule.fromJson(i))
            .toList(),
        trackings = (json['trackings'] as List)
            .map((i) => BLTracking.fromJson(i))
            .toList(),
        marks = (json['marks'] as List).map((i) => BLMark.fromJson(i)).toList(),
        descs = (json['descs'] as List).map((i) => BLDesc.fromJson(i)).toList(),
        bkCntrs =
            (json['bkCntrs'] as List).map((i) => BLBkCntr.fromJson(i)).toList(),
        blCntrs =
            (json['blCntrs'] as List).map((i) => BLBlCntr.fromJson(i)).toList(),
        dgSpecials = (json['dgSpecials'] as List)
            .map((i) => BLDgSpecial.fromJson(i))
            .toList(),
        freights = (json['freights'] as List)
            .map((i) => BLFreight.fromJson(i))
            .toList();
}
