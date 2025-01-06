import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/repository/global_variabel.dart';



class DioInstance {
  late Dio _dio;

  DioInstance() {
    _dio = Dio(
      BaseOptions(
        baseUrl: GlobalVariables.baseUrl,
      ),
    );
    initializeInterceptors();
  }

  // All Method of Requests
  Future<Response> getRequest({required String endpoint, bool? isAuthorize, Map<String, dynamic>? queryParameters}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      response = await _dio.get(endpoint, queryParameters: queryParameters,
        options: Options(
            headers: {
              "Accept": "application/json",
              if (isAuthorize ?? false) "Authorization": "Bearer $token"
            }),
      );
    } on DioException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> postRequest({required String endpoint, bool? isAuthorize,bool? isMetaToken, Object? data, Map<String, dynamic>? queryParameters, bool isMultipart = false,}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = '';

    isMetaToken == true ?  token = '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' : token = prefs.getString('token');

    try {
      response = await _dio.post(
          endpoint,
          data: data,
          options: Options(
              headers: {
                "Accept": "application/json",
                if (isMultipart) "Content-Type": "multipart/form-data",
                if (isAuthorize ?? false) "Authorization": "Bearer $token"
              })
      );
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('DioException Response: ${e.response?.data}');
      print('DioException Status Code: ${e.response?.statusCode}');
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> patchRequest({required String endpoint, bool? isAuthorize, Object? data, Map<String, dynamic>? queryParameters}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      response = await _dio.patch(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: Options(
              headers: {
                "Accept": "application/json",
                if (isAuthorize ?? false) "Authorization": "Bearer $token"
              })
      );
    } on DioException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> logoutRequest({required String endpoint, bool? isAuthorize}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      response = await _dio.post(
          endpoint,
          options: Options(
              headers: {
                "Accept": "application/json",
                if (isAuthorize ?? false) "Authorization": "Bearer $token"
              })
      );
    } on DioException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> putRequest({required String endpoint, bool? isAuthorize, required Object data}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      response = await _dio.put(
          endpoint,
          data: data,
          options: Options(
              headers: {
                "Accept": "application/json",
                if (isAuthorize ?? false) "Authorization": "Bearer $token"
              })
      );
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('DioException Response: ${e.response?.data}');
      print('DioException Status Code: ${e.response?.statusCode}');
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> deleteRequest({required String endpoint, bool? isAuthorize, Object? data , Map<String, dynamic>? queryParameters}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      response = await _dio.delete(
          endpoint,
          data: data,
          queryParameters: queryParameters,
          options: Options(
              headers: {
                "Accept": "application/json",
                if (isAuthorize ?? false) "Authorization": "Bearer $token"
              })
      );
    } on DioException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  void initializeInterceptors() {
    _dio.interceptors.add(
        InterceptorsWrapper(
            onError: (error, handler) {
              print("Error: ${error.message}");
              return handler.next(error);
            },
            onRequest: (request, handler) {
              print("${request.method} ${request.path}");
              print("Request Headers: ${request.headers}");
              print("Request Data: ${request.data}");
              return handler.next(request);
            },
            onResponse: (response, handler) {
              print("Response Data: ${response.data}");
              return handler.next(response);
            }
        )
    );
  }
}
