import 'package:archive_secure/utils/env.dart';

class ApiEndpoints {
  static final String baseUrl = Env.baseUrl;

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String verifyPin = '/auth/verify-pin';

  static const String categories = '/categories';
  static const String credentials = '/credentials';
  static String credentialSearch = '/credentials/search';
  static String credentialById(String id) => '/credentials/$id';
  static String credentialPassword(String id) => '/credentials/$id/password';
  static String credentialFavorite(String id) => '/credentials/$id/favorite';
  static String credentialUnfavorite(String id) => '/credentials/$id/unfavorite';
  static String credentialToggleFavorite(String id) => '/credentials/$id/toggle-favorite';
  static const String credentialFavoritesList = '/credentials/favorites';

  static const String dashboard = '/dashboard/main';

  static const String profileMe = '/profile/me';
  static const String profileChangePin = '/profile/change-pin';
  static const String profileChangePassword = '/profile/change-password';

  static const String passwordGenerate = '/security/password-generator/generate';
  static const String passwordEvaluate = '/security/password-generator/evaluate';

  static const String profileImage = '/v1/profile-image';
  static const String profileImageFile = '/v1/profile-image/file';
}