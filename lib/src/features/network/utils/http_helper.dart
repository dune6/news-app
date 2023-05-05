import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class HttpHelper {
  static Future<dynamic> get(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParams,
      int timeout = 10}) async {
    debugPrint('HTTP GET $url, params : $queryParams, headers : $headers');
    Response response = await Dio().get(
      url,
      options: Options(
        headers: headers,
      ),
      queryParameters: queryParams,
    );
    debugPrint('HTTP GET response (${response.statusCode}) : $response');
    return response;
  }

  static Future<dynamic> post(String url,
      {Map<String, String>? headers,
      dynamic data,
      Map<String, String>? queryParams,
      int timeout = 10}) async {
    debugPrint(
        'HTTP POST $url, params : $queryParams, data : $data, headers : $headers');
    Response response = await Dio().post(
      url,
      data: data,
      options: Options(
        headers: headers,
      ),
      queryParameters: queryParams,
    );
    debugPrint('HTTP POST response (${response.statusCode}) : $response');
    return response;
  }

  static Future<dynamic> put(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? data,
      Map<String, String>? queryParams,
      int timeout = 10}) async {
    debugPrint(
        'HTTP PUT $url, params : $queryParams, data : $data, headers : $headers');
    Response response;
    try {
      response = await Dio().put(
        url,
        data: data,
        options: Options(
          headers: headers,
        ),
        queryParameters: queryParams,
      );
    } on DioError catch (e) {
      debugPrint(
          'HTTP PUT error ${e.response?.statusCode} : ${e.response?.data}');
      rethrow;
    } catch (e) {
      rethrow;
    }
    debugPrint('HTTP PUT response (${response.statusCode}) : $response');
    return response;
  }

  static Future<dynamic> delete(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParams,
      int timeout = 10}) async {
    debugPrint('HTTP DELETE $url, params : $queryParams, headers : $headers');
    Response response = await Dio().delete(
      url,
      options: Options(
        headers: headers,
      ),
      queryParameters: queryParams,
    );
    debugPrint('HTTP DELETE response (${response.statusCode}) : $response');
    return response;
  }
}
