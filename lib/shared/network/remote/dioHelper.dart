import 'package:dio/dio.dart';

import '../../constants/constants.dart';

class DioHelper {
  static late Dio dio;

  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: '$url/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {
        required String url,
        Map<String,dynamic>? query,
        String lang='en',
        String? token,
      }
      ) async {
    dio.options.headers={
      'lang':lang,
      'Authorization':token??'',
      'Content-Type':'application/json',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String lang='en',
    String? token,
  }) async{
    dio.options.headers=
    {
      'lang':lang,
      'Authorization':token??'',
      'Content-Type':'application/json',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }


  static Future<Response> updateData({
    required String url,
    String? token,
    String lang='en',
    required Map <String,dynamic> data,
    Map<String,dynamic>? query,
  })async{
    dio.options.headers={
      'lang':lang,
      'Authorization':token??'',
      'Content-Type':'application/json',
    };
    return await dio.put(
      url,
      data:data ,
      queryParameters: query,
    );
  }
}