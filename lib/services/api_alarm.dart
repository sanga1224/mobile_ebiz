import 'package:dio/dio.dart';
import 'package:mobile_ebiz/models/alarm/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiAlarm {
  static const String baseUrl = 'http://fastapi.sinokor.co.kr:8000';

  static Future<List<Message>> getMsgList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fcmToken = prefs.getString('fcmToken')!;

    String portlistUrl = 'getAlarmList/getAlarmList';
    var param = {'fcm_token': fcmToken};
    final response = await Dio().post(
      '$baseUrl/$portlistUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      List<Message> instances =
          responseMap.map((e) => Message.fromJson(e)).toList();
      return instances;
    }
    throw Error();
  }

  static Future<int> getCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fcmToken = prefs.getString('fcmToken')!;

    String portlistUrl = 'getNotReadAlarm/getNotReadAlarm';
    var param = {'fcm_token': fcmToken};
    final response = await Dio().post(
      '$baseUrl/$portlistUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      return responseMap[0]['cnt'];
    }
    throw Error();
  }
}
