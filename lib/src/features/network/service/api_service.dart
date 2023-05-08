import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:surf_logger/surf_logger.dart';
import '../utils/http_helper.dart';

abstract class IApiService {
  Future<List<Map<String, dynamic>>> getTList(String section);
}

class ApiService {
  static const String _endPoint = 'https://api.nytimes.com/svc/topstories/v2';
  static const String _apiToken = 'vhE2AxgXhNTfcsA9BgAhUFaGTKzwlnOW';

  Future<List<Map<String, dynamic>>> getTList(String section) async {
    var query = {'api-key': _apiToken};
    Response response =
        await HttpHelper.get('$_endPoint/$section.json', queryParams: query);
    Logger.d('Response code: ${response.statusCode}');
    if (response.statusCode == 200) {
      Logger.d(response.data.runtimeType.toString());
      return (response.data['results'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    }
    throw Exception('error fetching articles');
  }
}
