import 'package:archive_secure/features/profile_image/domain/repositories/profile_image_repository.dart';

class DeleteProfileImage {
  final ProfileImageRepository _repository;

  DeleteProfileImage(this._repository);

  Future<void> call() {
    return _repository.deleteProfileImage();
  }
}
