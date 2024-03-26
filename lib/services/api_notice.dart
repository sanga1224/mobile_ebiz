import 'package:dio/dio.dart';
import 'package:mobile_ebiz/models/account/notice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiNotice {
  static const String baseUrl = 'http://fastapi.sinokor.co.kr:8000';

  static Future<List<Notice>> getList(num pageIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nacd = prefs.getString('userNacd') ?? 'EN';
    String detailUrl = 'getNotice/getNotice';
    var param = {'nacd': nacd, 'pageIndex': (pageIndex + 1).toString()};
    final response = await Dio().post(
      '$baseUrl/$detailUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      List<Notice> result = responseMap.map((e) => Notice.fromJson(e)).toList();
      return result;
    }
    throw Error();
  }
}
