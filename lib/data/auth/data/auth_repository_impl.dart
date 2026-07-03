import 'package:archive_secure/core/security/token_storage.dart';
import 'package:archive_secure/data/auth/data/dto/auth_dto.dart';
import 'package:archive_secure/data/auth/data/source/network/api.dart';
import 'package:archive_secure/data/auth/domain/entity/auth.dart';
import 'package:archive_secure/data/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Api _api;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._api, this._tokenStorage);

  @override
  Future<Auth> login(String email, String password) async {
    final dto = AuthDto(email: email, password: password);
    final response = await _api.login(dto);

    final auth = Auth(
      id: response.id,
      name: response.name,
      email: response.email,
      roleId: response.roleId,
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );

    await _saveSession(auth);
    return auth;
  }

  @override
  Future<Auth> register(
    String name,
    String email,
    String password,
    String pin,
  ) async {
    final dto = RegisterDto(
      name: name,
      email: email,
      password: password,
      pin: pin,
    );
    final response = await _api.register(dto);

    final auth = Auth(
      id: response.id,
      name: response.name,
      email: response.email,
      roleId: response.roleId,
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );

    await _saveSession(auth);
    return auth;
  }

  Future<void> _saveSession(Auth auth) async {
    await _tokenStorage.saveTokens(
      accessToken: auth.accessToken,
      refreshToken: auth.refreshToken,
    );
    await _tokenStorage.saveUserId(auth.id);
    await _tokenStorage.saveUserName(auth.name);
    await _tokenStorage.saveUserEmail(auth.email);
    await _tokenStorage.saveUserRoleId(auth.roleId);
  }

  @override
  Future<bool> verifyPin(String pin) async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null) return false;
    final response = await _api.verifyPin(pin, token);
    return response.isValid;
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _tokenStorage.isLoggedIn();
  }

  @override
  Future<String?> getToken() async {
    return await _tokenStorage.getAccessToken();
  }

  @override
  Future<void> saveSession(Auth auth) async {
    await _saveSession(auth);
  }

  @override
  Future<void> clearSession() async {
    await _tokenStorage.clearAll();
  }

  @override
  Future<Auth> refreshToken() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null) throw Exception('No refresh token available');
    final dto = RefreshTokenDto(refreshToken: refreshToken);
    final response = await _api.refreshToken(dto);
    final id = await _tokenStorage.getUserId() ?? '';
    final name = await _tokenStorage.getUserName() ?? '';
    final email = await _tokenStorage.getUserEmail() ?? '';
    final roleId = await _tokenStorage.getUserRoleId() ?? '';

    final auth = Auth(
      id: id,
      name: name,
      email: email,
      roleId: roleId,
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
    await _tokenStorage.saveTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
    return auth;
  }

  @override
  Future<void> logout() async {
    try {
      final token = await _tokenStorage.getAccessToken();
      if (token != null) await _api.logout(token);
    } catch (_) {}
    await _tokenStorage.clearAll();
  }

  @override
  Future<Auth> refreshSession() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw Exception('No refresh token available');
    }
    final dto = RefreshTokenDto(refreshToken: refreshToken);
    final response = await _api.refreshToken(dto);
    final id = await _tokenStorage.getUserId() ?? '';
    final name = await _tokenStorage.getUserName() ?? '';
    final email = await _tokenStorage.getUserEmail() ?? '';
    final roleId = await _tokenStorage.getUserRoleId() ?? '';

    final auth = Auth(
      id: id,
      name: name,
      email: email,
      roleId: roleId,
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
    await _tokenStorage.saveTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
    return auth;
  }

  @override
  Future<void> enableBiometric() async {
    await _tokenStorage.saveBiometricEnabled(true);
  }

  @override
  Future<void> logoutWithBiometricPreserve() async {
    await _tokenStorage.clearForLogout(preserveBiometricLogin: true);
  }
}
