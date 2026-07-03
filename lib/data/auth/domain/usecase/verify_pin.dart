import 'package:archive_secure/data/auth/domain/repository/auth_repository.dart';

class VerifyPin {
  VerifyPin({required this._repository});

  final AuthRepository _repository;

  Future<bool> call(String pin) async {
    return await _repository.verifyPin(pin);
  }
}
