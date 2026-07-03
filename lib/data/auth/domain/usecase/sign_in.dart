import 'package:archive_secure/data/auth/domain/entity/auth.dart';
import 'package:archive_secure/data/auth/domain/repository/auth_repository.dart';

class SignIn {
  SignIn({required this._repository});

  final AuthRepository _repository;

  Future<Auth> call(String email, String password) async {
    return await _repository.login(email, password);
  }
}