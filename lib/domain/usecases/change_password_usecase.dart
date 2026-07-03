import 'package:archive_secure/domain/repositories/profile_repository_contract.dart';

class ChangePasswordUseCase {
  final ProfileRepository _repository;

  ChangePasswordUseCase({required ProfileRepository repository})
      : _repository = repository;

  Future<void> call({
    required String currentPassword,
    required String newPassword,
  }) async {
    return _repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
