import 'package:dio/dio.dart';

import '../interfaces/token_datasource.dart';

class TokenInterceptor extends Interceptor {
  final TokenDataSource accessTokenStorage;
  final TokenDataSource refreshTokenStorage;
  final Dio dio;

  TokenInterceptor({
    required this.accessTokenStorage,
    required this.refreshTokenStorage,
    required this.dio,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    print("INTERCEPTOR");
    final String? accessToken = accessTokenStorage.getToken();
    options.headers['Content-Type'] = 'Application/json';
    options.headers['Accept'] = 'Application/json';

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await accessTokenStorage.deleteToken();
    }

    super.onError(err, handler);
  }
}
