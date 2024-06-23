import 'package:dio/dio.dart';


import 'apis.dart'; // Ensure to import your API endpoint constants

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<Response<dynamic>> getRequest(String endpoint,
      {Map<String, dynamic>? queryParams, String? token}) async {
    try {
      final options = Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer $token',
          'ngrok-skip-browser-warning': 'true',
          'User-Agent': 'CustomUserAgent/1.0',
          'Accept': 'application/json',
        },
      );
      final response = await _dio.get(endpoint,
          queryParameters: queryParams, options: options);
      return response;
    } catch (e) {
      throw Exception('Failed to GET from $endpoint: $e');
    }
  }

  Future<Response> postRequest(String endpoint, Map<String, dynamic> data,
      {String? token}) async {
    try {
      print(endpoint);
      final options = Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : null);
      final response = await _dio.post(endpoint, data: data, options: options);
      print(response);
      return response;
    } catch (e) {
      throw Exception('Failed to POST to $endpoint: $e');
    }
  }

  Future<Response> postRequest2(String endpoint, FormData formData,
      {String? token}) async {
    try {
      final options = Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : null);
      final response =
          await _dio.post(endpoint, data: formData, options: options);
      return response;
    } catch (e) {
      throw Exception('Failed to POST to $endpoint: $e');
    }
  }

  Future<Response> deleteRequest(String endpoint, Map<String, dynamic> data,
      {String? token}) async {
    try {
      final options = Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : null);
      final response =
          await _dio.delete(endpoint, data: data, options: options);
      return response;
    } catch (e) {
      throw Exception('Failed to POST to $endpoint: $e');
    }
  }
}
