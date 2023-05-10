import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:news_app/src/features/network/service/api_service.dart';

/// Class utility for [ApiService]
class HttpHelper {
  static final dio = Dio(BaseOptions(
    responseType: ResponseType.json,
    receiveTimeout: const Duration(seconds: 60),
    connectTimeout: const Duration(seconds: 60),
    receiveDataWhenStatusError: true,
    contentType: 'application/json',
    baseUrl: 'https://api.nytimes.com',
  ));

  static Future<dynamic> get(String url,
      {Map<String, String>? headers, Map<String, dynamic>? queryParams}) async {
    debugPrint('HTTPS GET $url, params : $queryParams, headers : $headers');
    Response response = await dio.get(
      url,
      options: Options(
        headers: headers,
      ),
      queryParameters: queryParams,
    );
    debugPrint('HTTPS GET response (${response.statusCode}) : $response');
    return response;
  }

  static Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    dynamic data,
    Map<String, String>? queryParams,
  }) async {
    debugPrint(
        'HTTPS POST $url, params : $queryParams, data : $data, headers : $headers');
    Response response = await dio.post(
      url,
      data: data,
      options: Options(
        headers: headers,
      ),
      queryParameters: queryParams,
    );
    debugPrint('HTTPS POST response (${response.statusCode}) : $response');
    return response;
  }

  static Future<dynamic> put(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? data,
    Map<String, String>? queryParams,
  }) async {
    debugPrint(
        'HTTPS PUT $url, params : $queryParams, data : $data, headers : $headers');
    Response response;
    try {
      response = await dio.put(
        url,
        data: data,
        options: Options(
          headers: headers,
        ),
        queryParameters: queryParams,
      );
    } on DioError catch (e) {
      debugPrint(
          'HTTPS PUT error ${e.response?.statusCode} : ${e.response?.data}');
      rethrow;
    } catch (e) {
      rethrow;
    }
    debugPrint('HTTP PUT response (${response.statusCode}) : $response');
    return response;
  }

  static Future<dynamic> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    debugPrint('HTTPS DELETE $url, params : $queryParams, headers : $headers');
    Response response = await dio.delete(
      url,
      options: Options(
        headers: headers,
      ),
      queryParameters: queryParams,
    );
    debugPrint('HTTPS DELETE response (${response.statusCode}) : $response');
    return response;
  }
}
