import 'package:archive_secure/domain/entities/dashboard_entity.dart';

abstract class DashboardRepository {
  Future<DashboardEntity> getDashboard();
}
