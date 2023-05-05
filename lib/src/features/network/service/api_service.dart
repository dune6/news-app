import 'package:dio/dio.dart';
import '../utils/http_helper.dart';

abstract class IApiService {
  Future<Map<String, dynamic>> getTList(String section);
}

class ApiService {
  static const String _endPoint = 'https://api.nytimes.com/svc/topstories/v2';
  static const String _apiToken = 'vhE2AxgXhNTfcsA9BgAhUFaGTKzwlnOW';

  Future<Map<String, dynamic>> getTList(String section) async {
    var query = {'api-key': _apiToken};
    Response response =
        await HttpHelper.get('$_endPoint/$section.json', queryParams: query);
    Map<String, dynamic> data = response.data['results'];
    return data;
  }
}
