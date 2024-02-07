import 'package:dio/dio.dart';
import 'package:mobile_ebiz/models/schedule/port.dart';

class ApiPort {
  static const String baseUrl = 'http://fastapi.sinokor.co.kr:8000';
  static const String portlistUrl = 'portlist/portlist';

  static Future<List<Port>> getPortList() async {
    List<Port> portInstances = [];
    //final url = Uri.parse('$baseUrl/$portlistUrl');
    final response = await Dio().get('$baseUrl/$portlistUrl');
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      portInstances = responseMap.map((e) => Port.fromJson(e)).toList();
      return portInstances;
    }
    throw Error();
  }
}
