import 'package:archive_secure/core/security/token_storage.dart';
import 'package:archive_secure/utils/api_endpoints.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;
  final Dio _dio;
  final void Function() onSessionExpired;

  AuthInterceptor({
    required this._tokenStorage,
    required this._dio,
    required this.onSessionExpired,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.path.contains('/auth/')) {
      final token = await _tokenStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains('/auth/refresh')) {
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken != null) {
        try {
          final response = await _dio.post(
            ApiEndpoints.refresh,
            data: {'refreshToken': refreshToken},
            options: Options(headers: {'Content-Type': 'application/json'}),
          );
          final data = response.data['data'];
          final newAccessToken = data['accessToken'] as String;
          final newRefreshToken = data['refreshToken'] as String;

          await _tokenStorage.saveTokens(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
          );

          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';
          final retryResponse = await _dio.fetch(err.requestOptions);
          return handler.resolve(retryResponse);
        } catch (_) {
          onSessionExpired();
        }
      } else {
        onSessionExpired();
      }
    }
    handler.next(err);
  }
}
