import 'package:archive_secure/data/models/profile_model.dart';
import 'package:archive_secure/utils/api_endpoints.dart';
import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfileName(String name);
  Future<void> changePin({
    required String currentPin,
    required String newPin,
  });
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSourceImpl(this._dio);

  ProfileModel _parseProfile(dynamic responseData) {
    if (responseData is Map<String, dynamic> &&
        responseData['data'] is Map<String, dynamic>) {
      return ProfileModel.fromJson(
          responseData['data'] as Map<String, dynamic>);
    }
    throw Exception('Formato de respuesta inválido');
  }

  @override
  Future<ProfileModel> getProfile() async {
    final response = await _dio.get(ApiEndpoints.profileMe);
    return _parseProfile(response.data);
  }

  @override
  Future<ProfileModel> updateProfileName(String name) async {
    final response = await _dio.put(
      ApiEndpoints.profileMe,
      data: {'name': name},
    );
    return _parseProfile(response.data);
  }

  @override
  Future<void> changePin({
    required String currentPin,
    required String newPin,
  }) async {
    await _dio.patch(
      ApiEndpoints.profileChangePin,
      data: {'currentPin': currentPin, 'newPin': newPin},
    );
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _dio.patch(
      ApiEndpoints.profileChangePassword,
      data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
  }
}
