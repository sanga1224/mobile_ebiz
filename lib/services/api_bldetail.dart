import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_ebiz/models/bldetail/bldetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiBLDetail {
  static const String baseUrl = 'http://fastapi.sinokor.co.kr:8000';

  static Future<BLDetail> getBLDetail(String blno) async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceId;
    if (kIsWeb) {
      final webBrowserInfo = await deviceInfo.webBrowserInfo;
      deviceId =
          '${webBrowserInfo.vendor ?? '-'} + ${webBrowserInfo.userAgent ?? '-'} + ${webBrowserInfo.hardwareConcurrency.toString()}';
    } else if (Platform.isAndroid) {
      const androidId = AndroidId();
      deviceId = await androidId.getId();
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    } else if (Platform.isLinux) {
      final linuxInfo = await deviceInfo.linuxInfo;
      deviceId = linuxInfo.machineId;
    } else if (Platform.isWindows) {
      final windowsInfo = await deviceInfo.windowsInfo;
      deviceId = windowsInfo.deviceId;
    } else if (Platform.isMacOS) {
      final macOsInfo = await deviceInfo.macOsInfo;
      deviceId = macOsInfo.systemGUID;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nacd = prefs.getString('userNacd') ?? 'EN';

    String portlistUrl = 'getBlDetail/getBlDetail';
    var param = {'deviceId': deviceId, 'nacd': nacd, 'blno': blno};
    //final url = Uri.parse('$baseUrl/$portlistUrl');
    final response = await Dio().post(
      '$baseUrl/$portlistUrl',
      queryParameters: param,
      // options: Options(
      //     headers: {HttpHeaders.contentTypeHeader: 'application/json'})
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      BLDetail instances =
          responseMap.map((e) => BLDetail.fromJson(e)).toList()[0];
      return instances;
    }
    throw Error();
  }
}
