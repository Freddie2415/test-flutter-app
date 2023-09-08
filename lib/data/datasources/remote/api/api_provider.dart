import 'dart:io';

import 'package:app/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

typedef Json = Map<String, dynamic>;

class ApiProvider {
  final String baseUrl;
  final Dio dio;

  ApiProvider(
    this.dio,
    this.baseUrl,
  );

  Future<T> _request<T>(
    String url, {
    String method = 'GET',
    Json? data,
    Json? queryParams,
  }) async {
    try {
      Response response;

      switch (method) {
        case 'GET':
          response = await dio.get(
            url,
            queryParameters: queryParams,
          );
          break;
        case 'POST':
          response = await dio.post(
            url,
            data: data,
            queryParameters: queryParams,
          );
          break;
        case 'PUT':
          response = await dio.put(
            url,
            data: data,
            queryParameters: queryParams,
          );
          break;
        default:
          throw RequestErrorException('Unsupported HTTP method: $method');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data as T;
      } else {
        throw ServerErrorException(response.statusCode ?? 0, 'Server Error');
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NoInternetException('No internet connection');
      } else if (e.response != null && e.response?.statusCode != null) {
        throw ServerErrorException(e.response?.statusCode ?? 0, 'Server Error');
      } else {
        throw RequestErrorException('Request Error: $e');
      }
    } catch (e) {
      throw RequestErrorException('Failed to make request: $e');
    }
  }

  Future<T> get<T>(
    String url, {
    Json? queryParams,
  }) async {
    return _request<T>(
      url,
      method: 'GET',
      queryParams: queryParams,
    );
  }

  Future<T> post<T>(
    String url, {
    Json? data,
    Json? queryParams,
  }) async {
    return _request<T>(
      url,
      method: 'POST',
      data: data,
      queryParams: queryParams,
    );
  }

  Future<T> put<T>(
    String url, {
    Json? data,
    Json? queryParams,
  }) async {
    return _request<T>(
      url,
      method: 'PUT',
      data: data,
      queryParams: queryParams,
    );
  }
}
