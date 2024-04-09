import 'dart:io' show Platform;
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_ebiz/models/account/profile.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:mobile_ebiz/models/account/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiLogIn {
  static const String baseUrl = 'http://fastapi.sinokor.co.kr:8000';

  static Future<StatusMsg> getLogIn(String userid, String pwd) async {
    String detailUrl = 'getlogin/getlogin';
    var param = {'uid': userid, 'upwd': pwd};
    final response = await Dio().post(
      '$baseUrl/$detailUrl',
      queryParameters: param,
      // options: Options(
      //     headers: {HttpHeaders.contentTypeHeader: 'application/json'})
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      StatusMsg result =
          responseMap.map((e) => StatusMsg.fromJson(e)).toList()[0];
      return result;
    }
    throw Error();
  }

  static Future<StatusMsg> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('login_token')!;
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

    String detailUrl = 'delMobileProfileInfo/delMobileProfileInfo';
    var param = {'deviceId': deviceId, 'token': token};
    final response = await Dio().post(
      '$baseUrl/$detailUrl',
      queryParameters: param,
      // options: Options(
      //     headers: {HttpHeaders.contentTypeHeader: 'application/json'})
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      StatusMsg result =
          responseMap.map((e) => StatusMsg.fromJson(e)).toList()[0];
      return result;
    }
    throw Error();
  }

  static Future<StatusMsg> chkLogIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('login_token')!;
    String detailUrl = 'chklogin/chklogin';
    var param = {'token': token};
    final response = await Dio().post(
      '$baseUrl/$detailUrl',
      queryParameters: param,
      // options: Options(
      //     headers: {HttpHeaders.contentTypeHeader: 'application/json'})
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      StatusMsg result =
          responseMap.map((e) => StatusMsg.fromJson(e)).toList()[0];
      return result;
    }
    throw Error();
  }

  static Future<Profile> getProfile(int profileSeq) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('login_token')!;
    String fcmToken = prefs.getString('fcmToken')!;
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
    String detailUrl = 'getProfile/getProfile';
    var param = {
      'deviceId': deviceId,
      'token': token,
      'fcmToken': fcmToken,
      'profile_seq': profileSeq.toString()
    };
    final response = await Dio().post(
      '$baseUrl/$detailUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      Profile result = responseMap.map((e) => Profile.fromJson(e)).toList()[0];
      return result;
    }
    throw Error();
  }

  static Future<List<Profile>> getProfiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('login_token')!;
    String detailUrl = 'getProfiles/getProfiles';
    var param = {'token': token};
    final response = await Dio().post(
      '$baseUrl/$detailUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      List<Profile> result =
          responseMap.map((e) => Profile.fromJson(e)).toList();
      return result;
    }
    throw Error();
  }

  static Future<StatusMsg> saveProfile(
      int profileSeq,
      int icon,
      String nickName,
      String name,
      String cellNo,
      String email,
      String telNo,
      String faxNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('login_token')!;
    String detailUrl = 'saveProfile/saveProfile';
    var param = {
      'token': token,
      'profile_seq': profileSeq,
      'icon': icon,
      'nickname': nickName,
      'name': name,
      'cellno': cellNo,
      'email': email,
      'telno': telNo,
      'faxno': faxNo
    };
    final response = await Dio().post(
      '$baseUrl/$detailUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      StatusMsg result =
          responseMap.map((e) => StatusMsg.fromJson(e)).toList()[0];
      return result;
    }
    throw Error();
  }

  static Future<StatusMsg> deleteProfile(int profileSeq) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('login_token')!;
    String detailUrl = 'deleteProfile/deleteProfile';
    var param = {'token': token, 'profile_seq': profileSeq};
    final response = await Dio().post(
      '$baseUrl/$detailUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      StatusMsg result =
          responseMap.map((e) => StatusMsg.fromJson(e)).toList()[0];
      return result;
    }
    throw Error();
  }

  static Future<StatusMsg> setProfile(int profileSeq) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('login_token')!;
    String fcmToken = prefs.getString('fcmToken')!;
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
    String detailUrl = 'setProfile/setProfile';
    var param = {
      'deviceid': deviceId,
      'token': token,
      'fcmToken': fcmToken,
      'profile_seq': profileSeq,
    };
    final response = await Dio().post(
      '$baseUrl/$detailUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      StatusMsg result =
          responseMap.map((e) => StatusMsg.fromJson(e)).toList()[0];
      return result;
    }
    throw Error();
  }

  static Future<User> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('login_token')!;
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
    String detailUrl = 'getUserInfo/getUserInfo';
    var param = {'deviceId': deviceId, 'token': token};
    final response = await Dio().post(
      '$baseUrl/$detailUrl',
      queryParameters: param,
      // options: Options(
      //     headers: {HttpHeaders.contentTypeHeader: 'application/json'})
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      User result = responseMap.map((e) => User.fromJson(e)).toList()[0];
      return result;
    }
    throw Error();
  }
}
