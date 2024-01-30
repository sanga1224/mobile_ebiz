import 'package:dio/dio.dart';
import 'package:mobile_ebiz/models/status_msg.dart';

class ApiLogIn {
  static const String baseUrl = 'http://fastapi.sinokor.co.kr:8000';

  static Future<StatusMsg> getLogIn(String userid, String pwd) async {
    String getLogInUrl = 'getlogin/getlogin';
    var param = {'uid': userid, 'upwd': pwd};
    final response = await Dio().post(
      '$baseUrl/$getLogInUrl',
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

  static Future<StatusMsg> chkLogIn(String token) async {
    String chkLogInUrl = 'chklogin/chklogin';
    var param = {'token': token};
    final response = await Dio().post(
      '$baseUrl/$chkLogInUrl',
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
}
