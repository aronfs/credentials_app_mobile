import 'package:archive_secure/domain/entities/profile_entity.dart';
import 'package:archive_secure/domain/repositories/profile_repository_contract.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase({required ProfileRepository repository})
      : _repository = repository;

  Future<ProfileEntity> call() async {
    return _repository.getProfile();
  }
}
