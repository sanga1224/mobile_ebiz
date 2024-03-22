import 'package:dio/dio.dart';
import 'package:mobile_ebiz/models/bl/bl_trackingmap.dart';

class ApiMap {
  static const String baseUrl = 'http://fastapi.sinokor.co.kr:8000';

  static Future<BLTrackingMap> getTrackingMapData(String blno) async {
    String portlistUrl = 'getTrackingMap/getTrackingMap';
    var param = {'blno': blno};
    //final url = Uri.parse('$baseUrl/$portlistUrl');
    final response = await Dio().post(
      '$baseUrl/$portlistUrl',
      queryParameters: param,
      // options: Options(
      //     headers: {HttpHeaders.contentTypeHeader: 'application/json'})
    );
    if (response.statusCode == 200) {
      List<dynamic> responseMap = response.data['ResultData'];
      BLTrackingMap instances =
          responseMap.map((e) => BLTrackingMap.fromJson(e)).toList()[0];
      return instances;
    }
    throw Error();
  }
}
