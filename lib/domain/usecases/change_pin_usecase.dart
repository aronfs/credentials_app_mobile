import 'package:archive_secure/domain/repositories/profile_repository_contract.dart';

class ChangePinUseCase {
  final ProfileRepository _repository;

  ChangePinUseCase({required ProfileRepository repository})
      : _repository = repository;

  Future<void> call({
    required String currentPin,
    required String newPin,
  }) async {
    return _repository.changePin(currentPin: currentPin, newPin: newPin);
  }
}
