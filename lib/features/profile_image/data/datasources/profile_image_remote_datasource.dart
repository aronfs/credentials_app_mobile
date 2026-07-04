import 'package:archive_secure/features/profile_image/data/models/profile_image_model.dart';
import 'package:archive_secure/utils/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'dart:typed_data';

abstract class ProfileImageRemoteDataSource {
  Future<ProfileImageModel?> getProfileImage();
  Future<Uint8List> getProfileImageFile();
  Future<ProfileImageModel> uploadProfileImage(String filePath, String mimeType);
  Future<void> deleteProfileImage();
}

class ProfileImageRemoteDataSourceImpl implements ProfileImageRemoteDataSource {
  final Dio _dio;

  ProfileImageRemoteDataSourceImpl(this._dio);

  @override
  Future<ProfileImageModel?> getProfileImage() async {
    final response = await _dio.get(ApiEndpoints.profileImage);
    final data = response.data['data'];
    if (data == null) return null;
    return ProfileImageModel.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<Uint8List> getProfileImageFile() async {
    final response = await _dio.get(
      ApiEndpoints.profileImageFile,
      options: Options(responseType: ResponseType.bytes),
    );
    return response.data as Uint8List;
  }

  @override
  Future<ProfileImageModel> uploadProfileImage(
    String filePath,
    String mimeType,
  ) async {
    final fileName = filePath.split('/').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      ),
    });
    final response = await _dio.post(
      ApiEndpoints.profileImage,
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );
    return ProfileImageModel.fromJson(
        response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteProfileImage() async {
    await _dio.delete(ApiEndpoints.profileImage);
  }
}
