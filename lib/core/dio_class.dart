import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'cache_manager.dart';

class DioHelper {
  static const String baseUrl = 'https://192.168.84.84:44332';
  static late Dio _dio;
  static void init() {
    _dio = Dio();
  }

  static Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    final String url = '$baseUrl$endPoint';
    final token = await CacheHelper.getToken();
    final options = Options(headers: {'Authorization': 'Bearer $token'});
    return await _dio.get(url, queryParameters: query, options: options);
  }

  static Future<Response> post({
    required String endPoint,
    String? token,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    final String url = '$baseUrl$endPoint';
    final options = Options(headers: {'Authorization': 'Bearer $token'});
    return await _dio.post(url, data: data, queryParameters: query, options: options);
  }

  static void log(String data) {
    if (kDebugMode) debugPrint(data);
  }
}
