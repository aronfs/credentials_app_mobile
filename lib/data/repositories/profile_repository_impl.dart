import 'package:archive_secure/data/datasources/profile_remote_datasource.dart';
import 'package:archive_secure/domain/entities/profile_entity.dart';
import 'package:archive_secure/domain/repositories/profile_repository_contract.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<ProfileEntity> getProfile() async {
    final model = await _remoteDataSource.getProfile();
    return model.toEntity();
  }

  @override
  Future<ProfileEntity> updateProfileName(String name) async {
    final model = await _remoteDataSource.updateProfileName(name);
    return model.toEntity();
  }

  @override
  Future<void> changePin({
    required String currentPin,
    required String newPin,
  }) async {
    await _remoteDataSource.changePin(currentPin: currentPin, newPin: newPin);
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _remoteDataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
