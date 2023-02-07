import 'package:dio/dio.dart';

class DioHelper {

  static Dio? dio;

  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: 'https://tasks.eraasoft.com/api/',
          receiveDataWhenStatusError: true,
        )
    );
  }

 static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token',


    };
    return await dio!.get(url, queryParameters: query);
  }






  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token',
    };
    return dio!.post(url, queryParameters: query, data: data);
  }






    static Future<Response> putData({
      required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String? token,
    }) {
      dio!.options.headers = {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      };
      return dio!.post(url, queryParameters: query, data: data);
    }


  static Future<Response> deleteData(
      {required String url, String? token}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    };
    return await dio!.delete(url);
  }

  }