import 'package:dio/dio.dart';
import 'package:mobile_ebiz/models/print/print.dart';

class ApiPrint {
  static const String baseUrl = 'http://fastapi.sinokor.co.kr:8000';

  static Future<Print> getPrintData(
      String nacd, String token, String div, String blno) async {
    String detailUrl = 'getPrintData/getPrintData';
    var param = {
      'nacd': nacd,
      'token': token,
      'div': div,
      'blno': blno,
    };
    final response = await Dio().post(
      '$baseUrl/$detailUrl',
      queryParameters: param,
      // options: Options(
      //     headers: {HttpHeaders.contentTypeHeader: 'application/json'})
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      Print result = responseMap.map((e) => Print.fromJson(e)).toList()[0];
      return result;
    }
    throw Error();
  }
}
