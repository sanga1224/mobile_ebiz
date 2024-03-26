import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_ebiz/models/bl/bldetail.dart';
import 'package:mobile_ebiz/models/bl/favorite.dart';
import 'package:mobile_ebiz/models/bl/recent.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiBL {
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
    String token = prefs.getString('login_token')!;

    String portlistUrl = 'getBlDetail/getBlDetail';
    var param = {
      'deviceId': deviceId,
      'token': token,
      'nacd': nacd,
      'blno': blno
    };
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

  static Future<List<FavoriteBL>> getFavorite() async {
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
    String token = prefs.getString('login_token')!;

    String portlistUrl = 'getFavoriteBL/getFavoriteBL';
    var param = {
      'deviceid': deviceId,
      'token': token,
    };
    final response = await Dio().post(
      '$baseUrl/$portlistUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      List<FavoriteBL> instances =
          responseMap.map((e) => FavoriteBL.fromJson(e)).toList();
      return instances;
    }
    throw Error();
  }

  static Future<StatusMsg> addFavorite(String blno, String msg) async {
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
    String token = prefs.getString('login_token')!;

    String portlistUrl = 'addFavoriteBL/addFavoriteBL';
    var param = {
      'deviceid': deviceId,
      'token': token,
      'blno': blno,
      'msg': msg
    };
    final response = await Dio().post(
      '$baseUrl/$portlistUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      StatusMsg instances =
          responseMap.map((e) => StatusMsg.fromJson(e)).toList()[0];
      return instances;
    }
    throw Error();
  }

  static Future<StatusMsg> delFavorite(String blno) async {
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
    String token = prefs.getString('login_token')!;

    String portlistUrl = 'delFavoriteBL/delFavoriteBL';
    var param = {'deviceid': deviceId, 'token': token, 'blno': blno};
    final response = await Dio().post(
      '$baseUrl/$portlistUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      StatusMsg instances =
          responseMap.map((e) => StatusMsg.fromJson(e)).toList()[0];
      return instances;
    }
    throw Error();
  }

  static Future<List<RecentBL>> getRecentBL() async {
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
    String token = prefs.getString('login_token')!;

    String portlistUrl = 'getRecentBL/getRecentBL';
    var param = {
      'deviceid': deviceId,
      'token': token,
    };
    final response = await Dio().post(
      '$baseUrl/$portlistUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      List<RecentBL> instances =
          responseMap.map((e) => RecentBL.fromJson(e)).toList();
      return instances;
    }
    throw Error();
  }

  static Future<StatusMsg> addRecentBL(String blno) async {
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
    String token = prefs.getString('login_token')!;

    String portlistUrl = 'addRecentBL/addRecentBL';
    var param = {'deviceid': deviceId, 'token': token, 'blno': blno};
    final response = await Dio().post(
      '$baseUrl/$portlistUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      StatusMsg instances =
          responseMap.map((e) => StatusMsg.fromJson(e)).toList()[0];
      return instances;
    }
    throw Error();
  }

  static Future<StatusMsg> delRecentBL(String blno) async {
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
    String token = prefs.getString('login_token')!;

    String portlistUrl = 'delRecentBL/delRecentBL';
    var param = {'deviceid': deviceId, 'token': token, 'blno': blno};
    final response = await Dio().post(
      '$baseUrl/$portlistUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      StatusMsg instances =
          responseMap.map((e) => StatusMsg.fromJson(e)).toList()[0];
      return instances;
    }
    throw Error();
  }

  static Future<List<String>> findBlNo(String postfix) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('login_token')!;

    String portlistUrl = 'findBlNo/findBlNo';
    var param = {'token': token, 'postfix': postfix};
    final response = await Dio().post(
      '$baseUrl/$portlistUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      List<String> instances =
          responseMap.map((e) => e['BLNO'].toString()).toList();
      return instances;
    }
    throw Error();
  }
}
