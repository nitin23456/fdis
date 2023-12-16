import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  final Dio dio = Dio();
  // static const String BASE_URL = 'http://3.121.115.115:4002/';
  // static const String BASE_URL = 'http://34.245.60.213:4002/';
  static const String BASE_URL = 'http://18.159.111.224:4002/';
  // http://34.245.60.213:4002/api/v1/dashboard'

  Api() {
    dio.options.baseUrl = BASE_URL;
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: false,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  // Post:----------------------------------------------------------------------
  Future<Response> postDataWithFile(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool? isUpdate
  }) async {
    try {

      final Response response = await (isUpdate==true?dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,)
      :dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
      {required String endpoint, required Map<String, dynamic> body}) async {
    try {
      final response = await dio.post(endpoint, data: body);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint not found');
      } else {
        throw Exception('An error occurred while making the request');
      }
    } catch (e) {
      throw Exception('An error occurred while making the request');
    }
  }

  Future<Response> postData({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, dynamic>? headers, // Add headers parameter
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: body,
        options: Options(headers: headers), // Pass headers to options
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint not found');
      } else {
        throw Exception('An error occurred while making the request');
      }
    } catch (e) {
      throw Exception('An error occurred while making the request');
    }
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? header}) async {
    try {
      Options options = Options(headers: header);
      final response = await dio.get(endpoint, options: options);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint not found');
      } else {
        throw Exception('An error occurred while making the request');
      }
    } catch (e) {
      throw Exception('An error occurred while making the request');
    }
  }
}
