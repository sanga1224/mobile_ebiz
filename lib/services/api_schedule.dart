import 'package:dio/dio.dart';
import 'package:mobile_ebiz/models/schedule/myschedule.dart';
import 'package:mobile_ebiz/models/schedule/schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiSchedule {
  static const String baseUrl = 'http://fastapi.sinokor.co.kr:8000';
  static const String portlistUrl =
      'port-to-port-schedule/port-to-port-schedule';
  static const String myScheduleListUrl = 'getMySchedule/getMySchedule';

  static Future<List<Schedule>> getList(String pol, String pod, String etd,
      String sortBy, bool descending) async {
    var param = {
      'apikey': '8GDHKXESCULRE8RNAD7JSMUPOQRDSF',
      'pol': pol,
      'pod': pod,
      'etd': etd
    };
    List<Schedule> portInstances = [];
    //final url = Uri.parse('$baseUrl/$portlistUrl');
    final response = await Dio().post(
      '$baseUrl/$portlistUrl',
      queryParameters: param,
      // options: Options(
      //     headers: {HttpHeaders.contentTypeHeader: 'application/json'})
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      portInstances = responseMap.map((e) => Schedule.fromJson(e)).toList();
      if (descending == false) {
        //ascending
        portInstances.sort((a, b) => (sortBy == 'etd'
            ? a.departureDate.compareTo(b.departureDate)
            : a.arrivalDate.compareTo(b.arrivalDate)));
      } else {
        //descending
        portInstances.sort((b, a) => (sortBy == 'etd'
            ? a.departureDate.compareTo(b.departureDate)
            : a.arrivalDate.compareTo(b.arrivalDate)));
      }
      return portInstances;
    }
    throw Error();
  }

  static Future<List<MySchedule>> getMySchedule() async {
    List<MySchedule> result = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('login_token');
    if (token != '') {
      final response = await Dio().post(
        '$baseUrl/$myScheduleListUrl',
        queryParameters: {'token': token},
      );
      if (response.statusCode == 200) {
        List<dynamic> responseMap = response.data['ResultData'];
        result = responseMap.map((e) => MySchedule.fromJson(e)).toList();
      }
    }
    return result;
  }
}
