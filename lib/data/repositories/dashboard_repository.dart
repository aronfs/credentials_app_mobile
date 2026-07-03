import 'package:archive_secure/data/datasources/dashboard_remote_datasource.dart';
import 'package:archive_secure/domain/entities/dashboard_entity.dart';
import 'package:archive_secure/domain/repositories/dashboard_repository_contract.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remoteDataSource;

  DashboardRepositoryImpl(this._remoteDataSource);

  @override
  Future<DashboardEntity> getDashboard() async {
    final model = await _remoteDataSource.getDashboard();
    return model.toEntity();
  }
}
