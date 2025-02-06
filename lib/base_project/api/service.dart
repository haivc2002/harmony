import 'dart:async';

import 'package:harmony/base_project/package_widget.dart';

class Service {
  final Dio _dio;
  final String baseUrl;
  Service(this.baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(PrettyDioLogger());
  }

  final Duration _duration = const Duration(seconds: 3);

  // Future<Result<T>> get<T>({
  //   required String endpoint,
  //   Map<String, dynamic>? queryParams,
  //   required T Function(Map<String, dynamic>) fromJson,
  // }) async {
  //   try {
  //     final response = await _dio.get(endpoint, queryParameters: queryParams);
  //     return _handleResponse<T>(response, fromJson);
  //   } catch (e) {
  //     return Failure<T>(_handleError());
  //   }
  // }

  Future<Result<T>> post<T>({
    required String endpoint,
    Map<String, dynamic>? data,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _dio.post(endpoint, data: data).timeout(_duration);
      return _handleResponse<T>(response, fromJson);
    } on TimeoutException {
      return Failure<T>(Result.isTimeOut);
    } on DioException catch (dioException)  {
      if(dioException.type == DioExceptionType.connectionError) {
        return Failure<T>(Result.isNotConnect);
      } else {
        return Failure<T>(Result.isDueServer);
      }
    } catch (e) {
      return Failure<T>(Result.isDueServer);
    }
  }

  // Future<Result<T, Exception>> put<T>({
  //   required String endpoint,
  //   Map<String, dynamic>? data,
  //   required T Function(Map<String, dynamic>) fromJson,
  // }) async {
  //   try {
  //     final response = await _dio.put(endpoint, data: data);
  //     return _handleResponse<T>(response, fromJson);
  //   } catch (e) {
  //     return Failure<T, Exception>(_handleError(e));
  //   }
  // }
  //
  // Future<Result<T, Exception>> delete<T>({
  //   required String endpoint,
  //   Map<String, dynamic>? queryParams,
  //   required T Function(Map<String, dynamic>) fromJson,
  // }) async {
  //   try {
  //     final response = await _dio.delete(endpoint, queryParameters: queryParams);
  //     return _handleResponse<T>(response, fromJson);
  //   } catch (e) {
  //     return Failure<T, Exception>(_handleError(e));
  //   }
  // }

  Result<T> _handleResponse<T>(Response response, T Function(Map<String, dynamic>) fromJson) {
    if (response.statusCode == 200) {
      final data = response.data;
      return Success(fromJson(data));
    } else {
      return Failure<T>(Result.isHttp);
    }
  }
}