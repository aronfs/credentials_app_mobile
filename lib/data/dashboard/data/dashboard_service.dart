import 'package:archive_secure/core/security/token_storage.dart';
import 'package:archive_secure/data/dashboard/data/dashboard_models.dart';
import 'package:archive_secure/utils/api_endpoints.dart';
import 'package:dio/dio.dart';

class DashboardService {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  DashboardService(this._dio, this._tokenStorage);

  Future<String> _getToken() async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null) throw Exception('No authentication token');
    return token;
  }

  Future<DashboardMainModel> getMain() async {
    final token = await _getToken();
    final response = await _dio.get(
      ApiEndpoints.dashboard,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return DashboardMainModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}