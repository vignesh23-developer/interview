import 'package:dio/dio.dart';
import '../constants/api_contants.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        "Accept": "application/json",
      },
    ),
  );

  Future<Response> post(String url, dynamic data, {Options? options}) async {
    try {
      final response = await _dio.post(url, data: data,options: options);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}