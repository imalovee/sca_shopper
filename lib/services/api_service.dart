import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService{
late final Dio _dio;

  static final ApiService _singleton = ApiService._internal();

  factory ApiService() {
    return _singleton;
  }

  ApiService._internal(){
    _dio = Dio(BaseOptions(
        baseUrl: dotenv.get("base_url"),
    //     if (baseUrl == null || baseUrl.isEmpty) {
    // throw Exception("Base URL not defined or empty in .env file.");
    // }
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 50)
    ));

    _dio.interceptors.add(PrettyDioLogger(
      request: true,
      requestHeader: false,
      requestBody: true,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode
    ));

  }

  Future<({dynamic data, String? error})> get(
    {required String endPoint}
  )async{
    try {
      final request = await _dio.get(endPoint);
      final status = request.statusCode ?? 0;
      if(status > 199 && status < 300){
        return (data: request.data, error: null);
      }
      return (data: null, error:(request.data['message'] ?? "").toString());
    } catch (e) {
      String? msg;
      if(e is DioException){
        msg = e.response?.data['message'];
      }
      return (data: null, error: msg ?? e.toString());
    }
  }

  Future<({dynamic data, String? error})> post(
    {required String endPoint,
    required Map<String,dynamic> data
    }
  )async{
    try {
      final request = await _dio.post(endPoint, data: data);
      final status = request.statusCode ?? 0;
      if(status > 199 && status < 300){
        return (data: request.data, error: null);
      }
      return (data: null, error:(request.data['message'] ?? "").toString());
    } catch (e) {
      String? msg;
      if(e is DioException){
        msg = e.response?.data['message'];
      }
      return (data: null, error: msg ?? e.toString());
    }
  }
 
 Future<({dynamic data, String? error})> delete({
  required String endPoint,
  required Map<String, dynamic> data
 })async{
  try {
    final request = await _dio.delete(endPoint, data: data);
    final status = request.statusCode ?? 0;
    if(status > 199 && status < 300){
      return (data: request.data, error: null);
    }
    return (data: null, error: (request.data['message'] ?? "").toString());
  } catch (e) {
    String? msg;
    if(e is DioException){
      msg = e.response?.data['message'];
    }
    return (data: null, error: msg ?? e.toString());
  }
 }

Future<({dynamic data, String? error})> puth({
  required String endPoint,
  required Map<String, dynamic> data
})async{
  try {
    final request = await _dio.put(endPoint, data: data);
    final status = request.statusCode ?? 0;
    if(status > 199 && status > 300){
      return (data: request.data, error: null);
    }
    return (data: null, error:(request.data['message'] ?? "").toString());
  } catch (e) {
    String? msg;
    if(e is DioException){
      msg = e.response?.data['message'];
    }
    return (data: null, error: msg ?? e.toString());
  }
}
}