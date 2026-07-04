import 'package:archive_secure/features/profile_image/domain/entities/profile_image_entity.dart';
import 'package:archive_secure/features/profile_image/domain/repositories/profile_image_repository.dart';

class UploadProfileImage {
  final ProfileImageRepository _repository;

  UploadProfileImage(this._repository);

  Future<ProfileImageEntity> call(String filePath) {
    return _repository.uploadProfileImage(filePath);
  }
}
