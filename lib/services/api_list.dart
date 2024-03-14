import 'package:dio/dio.dart';
import 'package:mobile_ebiz/models/list/bl_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiList {
  static const String baseUrl = 'http://fastapi.sinokor.co.kr:8000';

  static Future<List<BLList>> getList(
      String bound, String fmdt, String todt, String pol, String pod) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('login_token')!;
    String detailUrl = 'getBlList/getBlList';
    var param = {
      'token': token,
      'bound': bound,
      'fmdt': fmdt,
      'todt': todt,
      'pol': pol,
      'pod': pod
    };
    final response = await Dio().post(
      '$baseUrl/$detailUrl',
      queryParameters: param,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      List<BLList> result = responseMap.map((e) => BLList.fromJson(e)).toList();
      return result;
    }
    throw Error();
  }
}
