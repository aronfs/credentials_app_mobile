import 'package:archive_secure/features/profile_image/domain/entities/profile_image_entity.dart';
import 'package:archive_secure/features/profile_image/domain/repositories/profile_image_repository.dart';

class GetProfileImage {
  final ProfileImageRepository _repository;

  GetProfileImage(this._repository);

  Future<ProfileImageEntity?> call() {
    return _repository.getProfileImage();
  }
}
