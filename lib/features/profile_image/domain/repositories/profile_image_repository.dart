import 'package:archive_secure/features/profile_image/domain/entities/profile_image_entity.dart';
import 'dart:typed_data';

abstract class ProfileImageRepository {
  Future<ProfileImageEntity?> getProfileImage();
  Future<Uint8List> getProfileImageFile();
  Future<ProfileImageEntity> uploadProfileImage(String filePath);
  Future<void> deleteProfileImage();
}
