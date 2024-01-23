import 'package:dio/dio.dart';
import 'package:mobile_ebiz/models/schedule.dart';

class ApiSchedule {
  static const String baseUrl = 'http://fastapi.sinokor.co.kr:8000';
  static const String portlistUrl =
      'port-to-port-schedule/port-to-port-schedule';

  static Future<List<Schedule>> getList(
      String pol, String pod, String etd) async {
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
      return portInstances;
    }
    throw Error();
  }
}
