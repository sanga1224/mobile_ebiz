import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ebiz/models/status_msg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonFunction {
  static const String baseUrl = 'http://fastapi.sinokor.co.kr:8000';

  static void showSnackBar(BuildContext context, String text, bool positive) {
    Text content = Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
    );
    final snackBar = SnackBar(
      content: content,
      backgroundColor:
          positive == true ? const Color.fromRGBO(0, 84, 166, 1) : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static bool isNumeric(String str) {
    if (str == '') {
      return false;
    }
    return num.tryParse(str) != null;
  }

  static Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('login_token');
    if (token == null || token == '') {
      return false;
    } else {
      return true;
    }
  }

  static Future setFcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Future<String?> fcmToken = FirebaseMessaging.instance.getToken();
    fcmToken.then((value) {
      debugPrint('Fcm token : $value');
      prefs.setString('fcmToken', value!);
    });
  }

  static Future<String> getEncording(String gb, String str) async {
    String detailUrl = 'getencording/getencording';
    var param = {'pGB': gb, 'pStr': str};
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
      return result.msg;
    } else {
      return '';
    }
  }

  static Future<String> getDecording(String gb, String str) async {
    String detailUrl = 'getdecording/getdecording';
    var param = {'pGB': gb, 'pStr': str};
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
      return result.msg;
    } else {
      return '';
    }
  }
}
