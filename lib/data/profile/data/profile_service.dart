import 'package:archive_secure/core/security/token_storage.dart';
import 'package:archive_secure/data/profile/data/profile_models.dart';
import 'package:archive_secure/utils/api_endpoints.dart';
import 'package:dio/dio.dart';

class ProfileService {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  ProfileService(this._dio, this._tokenStorage);

  Future<String> _getToken() async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null) throw Exception('No authentication token');
    return token;
  }

  Future<ProfileMeModel> getMe() async {
    final token = await _getToken();
    final response = await _dio.get(
      ApiEndpoints.profileMe,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return ProfileMeModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> updateProfile(String name) async {
    final token = await _getToken();
    final response = await _dio.put(
      ApiEndpoints.profileMe,
      data: {'name': name},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<void> changePin(String currentPin, String newPin) async {
    final token = await _getToken();
    await _dio.patch(
      ApiEndpoints.profileChangePin,
      data: {'currentPin': currentPin, 'newPin': newPin},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    final token = await _getToken();
    await _dio.patch(
      ApiEndpoints.profileChangePassword,
      data: {'currentPassword': currentPassword, 'newPassword': newPassword},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}