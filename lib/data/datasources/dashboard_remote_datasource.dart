import 'package:archive_secure/data/models/dashboard_model.dart';
import 'package:archive_secure/utils/api_endpoints.dart';
import 'package:dio/dio.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardModel> getDashboard();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio _dio;

  DashboardRemoteDataSourceImpl(this._dio);

  @override
  Future<DashboardModel> getDashboard() async {
    final response = await _dio.get(ApiEndpoints.dashboard);
    final data = response.data;
    if (data is Map<String, dynamic> && data['data'] is Map<String, dynamic>) {
      return DashboardModel.fromJson(data['data'] as Map<String, dynamic>);
    }
    throw Exception('Formato de respuesta inválido');
  }
}
