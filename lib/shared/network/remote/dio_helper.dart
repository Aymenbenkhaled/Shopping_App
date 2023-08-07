import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  //GET
  // base url ==> https://newsapi.org/
  // method (url) ==> v2/top-headlines?
  //queries ==> country=us&category=business&apiKey=cb55b2e91ef54db7845e76de69ab10fd

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true),
    );
  }

  static Future<Response> getData({
    required String url ,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'authorization': token,
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'authorization': token,
    };
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) {
    dio!.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'authorization': token,
    };
    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
