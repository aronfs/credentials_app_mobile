import 'package:archive_secure/data/auth/domain/entity/auth.dart';
import 'package:archive_secure/data/auth/domain/repository/auth_repository.dart';

class Register {
  Register({required this._repository});

  final AuthRepository _repository;

  Future<Auth> call(String name, String email, String password, String pin) async {
    return await _repository.register(name, email, password, pin);
  }
}
