import 'package:archive_secure/features/profile_image/domain/repositories/profile_image_repository.dart';
import 'dart:typed_data';

class GetProfileImageFile {
  final ProfileImageRepository _repository;

  GetProfileImageFile(this._repository);

  Future<Uint8List> call() {
    return _repository.getProfileImageFile();
  }
}
