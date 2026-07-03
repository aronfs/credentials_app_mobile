import 'package:archive_secure/core/security/token_storage.dart';

class SessionManager {
  final TokenStorage _tokenStorage;

  SessionManager(this._tokenStorage);

  Future<void> logout({bool preserveBiometric = false}) async {
    await _tokenStorage.clearForLogout(
      preserveBiometricLogin: preserveBiometric,
    );
  }
}
