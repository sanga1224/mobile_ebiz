import 'package:dio/dio.dart';
import 'package:mobile_ebiz/models/list/bl_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiList {
  static const String baseUrl = 'http://fastapi.sinokor.co.kr:8000';

  static Future<List<BLList>> getList(String bound, String fmdt, String todt,
      String pol, String pod, String sortby, bool descending) async {
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
      if (descending == false) {
        //ascending
        result.sort((a, b) => (sortby == 'etd'
            ? a.etd.compareTo(b.etd)
            : sortby == 'eta'
                ? a.eta.compareTo(b.eta)
                : a.blno.compareTo(b.blno)));
      } else {
        //descending
        result.sort((b, a) => (sortby == 'etd'
            ? a.etd.compareTo(b.etd)
            : sortby == 'eta'
                ? a.eta.compareTo(b.eta)
                : a.blno.compareTo(b.blno)));
      }
      return result;
    }
    throw Error();
  }
}
