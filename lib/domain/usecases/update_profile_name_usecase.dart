import 'package:archive_secure/domain/entities/profile_entity.dart';
import 'package:archive_secure/domain/repositories/profile_repository_contract.dart';

class UpdateProfileNameUseCase {
  final ProfileRepository _repository;

  UpdateProfileNameUseCase({required ProfileRepository repository})
      : _repository = repository;

  Future<ProfileEntity> call(String name) async {
    return _repository.updateProfileName(name);
  }
}
