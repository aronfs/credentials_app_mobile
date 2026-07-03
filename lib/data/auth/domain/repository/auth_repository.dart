import 'package:archive_secure/data/auth/domain/entity/auth.dart';

abstract class AuthRepository {
  Future<Auth> login(String email, String password);
  Future<Auth> register(String name, String email, String password, String pin);
  Future<bool> verifyPin(String pin);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<String?> getToken();
  Future<void> saveSession(Auth auth);
  Future<void> clearSession();
  Future<Auth> refreshToken();
  Future<Auth> refreshSession();
  Future<void> enableBiometric();
  Future<void> logoutWithBiometricPreserve();
}
