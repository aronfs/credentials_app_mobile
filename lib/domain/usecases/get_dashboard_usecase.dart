import 'package:archive_secure/domain/entities/dashboard_entity.dart';
import 'package:archive_secure/domain/repositories/dashboard_repository_contract.dart';

class GetDashboardUseCase {
  final DashboardRepository _repository;

  GetDashboardUseCase({required DashboardRepository repository})
      : _repository = repository;

  Future<DashboardEntity> call() async {
    return _repository.getDashboard();
  }
}
