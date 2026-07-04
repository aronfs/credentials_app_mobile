import 'package:archive_secure/features/profile_image/data/datasources/profile_image_remote_datasource.dart';
import 'package:archive_secure/features/profile_image/domain/entities/profile_image_entity.dart';
import 'package:archive_secure/features/profile_image/domain/repositories/profile_image_repository.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:typed_data';

class ProfileImageRepositoryImpl implements ProfileImageRepository {
  final ProfileImageRemoteDataSource _dataSource;
  final void Function() _onSessionExpired;

  static const _maxFileSize = 5 * 1024 * 1024;
  static const _allowedExtensions = ['jpg', 'jpeg', 'png', 'webp'];

  ProfileImageRepositoryImpl({
    required ProfileImageRemoteDataSource dataSource,
    required void Function() onSessionExpired,
  })  : _dataSource = dataSource,
        _onSessionExpired = onSessionExpired;

  @override
  Future<ProfileImageEntity?> getProfileImage() async {
    try {
      final model = await _dataSource.getProfileImage();
      return model?.toEntity();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<Uint8List> getProfileImageFile() async {
    try {
      return await _dataSource.getProfileImageFile();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<ProfileImageEntity> uploadProfileImage(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw const ProfileImageException('El archivo no existe.');
    }

    final extension = filePath.split('.').last.toLowerCase();
    if (!_allowedExtensions.contains(extension)) {
      throw const ProfileImageException(
        'Formato no permitido. Usa JPG, PNG o WEBP.',
      );
    }

    final fileSize = await file.length();
    if (fileSize > _maxFileSize) {
      throw const ProfileImageException(
        'El archivo supera el tamaño máximo de 5 MB.',
      );
    }

    final mimeType = _mimeFromExtension(extension);

    try {
      final model = await _dataSource.uploadProfileImage(filePath, mimeType);
      return model.toEntity();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  @override
  Future<void> deleteProfileImage() async {
    try {
      await _dataSource.deleteProfileImage();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  String _mimeFromExtension(String ext) {
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg';
    }
  }

  ProfileImageException _mapError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const ProfileImageException(
          'No se pudo conectar con el servidor');
    }
    if (e.type == DioExceptionType.connectionError) {
      return const ProfileImageException(
          'No se pudo conectar con el servidor');
    }

    final statusCode = e.response?.statusCode;
    switch (statusCode) {
      case 400:
        return const ProfileImageException('No se envió ningún archivo.');
      case 401:
        _onSessionExpired();
        return const ProfileImageException(
            'Sesión expirada. Inicia sesión nuevamente.');
      case 404:
        return const ProfileImageException('Foto de perfil no encontrada');
      case 413:
        return const ProfileImageException(
            'El archivo supera el tamaño máximo de 5 MB.');
      default:
        return const ProfileImageException(
            'Error al procesar la solicitud. Intente de nuevo.');
    }
  }
}

class ProfileImageException implements Exception {
  final String message;
  const ProfileImageException(this.message);

  @override
  String toString() => message;
}
