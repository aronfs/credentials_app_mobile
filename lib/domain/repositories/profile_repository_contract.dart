import 'package:archive_secure/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();
  Future<ProfileEntity> updateProfileName(String name);
  Future<void> changePin({
    required String currentPin,
    required String newPin,
  });
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
