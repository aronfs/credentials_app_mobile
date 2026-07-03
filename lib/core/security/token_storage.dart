import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userIdKey = 'user_id';
  static const _userNameKey = 'user_name';
  static const _userEmailKey = 'user_email';
  static const _userRoleIdKey = 'user_role_id';
  static const _userRoleKey = 'role';
  static const _permissionsKey = 'permissions';
  static const _biometricEnabledKey = 'biometric_enabled';

  final FlutterSecureStorage _storage;

  TokenStorage(this._storage);

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<void> saveUserId(String id) async {
    await _storage.write(key: _userIdKey, value: id);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: _userIdKey);
  }

  Future<void> saveUserName(String name) async {
    await _storage.write(key: _userNameKey, value: name);
  }

  Future<String?> getUserName() async {
    return await _storage.read(key: _userNameKey);
  }

  Future<void> saveUserEmail(String email) async {
    await _storage.write(key: _userEmailKey, value: email);
  }

  Future<String?> getUserEmail() async {
    return await _storage.read(key: _userEmailKey);
  }

  Future<void> saveUserRoleId(String roleId) async {
    await _storage.write(key: _userRoleIdKey, value: roleId);
  }

  Future<String?> getUserRoleId() async {
    return await _storage.read(key: _userRoleIdKey);
  }

  Future<void> saveUserRole(String role) async {
    await _storage.write(key: _userRoleKey, value: role);
  }

  Future<String?> getUserRole() async {
    return await _storage.read(key: _userRoleKey);
  }

  Future<void> savePermissions(String permissions) async {
    await _storage.write(key: _permissionsKey, value: permissions);
  }

  Future<String?> getPermissions() async {
    return await _storage.read(key: _permissionsKey);
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await saveAccessToken(accessToken);
    await saveRefreshToken(refreshToken);
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> saveBiometricEnabled(bool enabled) async {
    await _storage.write(key: _biometricEnabledKey, value: enabled.toString());
  }

  Future<bool> getBiometricEnabled() async {
    final value = await _storage.read(key: _biometricEnabledKey);
    return value == 'true';
  }

  Future<void> deleteBiometricFlag() async {
    await _storage.delete(key: _biometricEnabledKey);
  }

  Future<void> clearAccessToken() async {
    await _storage.delete(key: _accessTokenKey);
  }

  Future<void> clearForLogout({required bool preserveBiometricLogin}) async {
    final biometricEnabled = await getBiometricEnabled();
    final refreshToken = await getRefreshToken();
    final canPreserveBiometricLogin =
        preserveBiometricLogin &&
        biometricEnabled &&
        refreshToken != null &&
        refreshToken.isNotEmpty;

    if (canPreserveBiometricLogin) {
      await clearAccessToken();
      return;
    }

    await clearAll();
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
