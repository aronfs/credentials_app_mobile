import 'package:archive_secure/data/datasources/favorites_remote_datasource.dart';
import 'package:archive_secure/domain/entities/credential_entity.dart';
import 'package:archive_secure/domain/repositories/favorites_repository_contract.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource _remoteDataSource;

  FavoritesRepositoryImpl(this._remoteDataSource);

  @override
  Future<FavoriteCredentialsPageEntity> getFavorites({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    final response = await _remoteDataSource.getFavorites(
      page: page,
      limit: limit,
      search: search,
    );
    return FavoriteCredentialsPageEntity(
      items: response.items.map((e) => e.toEntity()).toList(),
      page: response.pagination.page,
      limit: response.pagination.limit,
      total: response.pagination.total,
      totalPages: response.pagination.totalPages,
    );
  }

  @override
  Future<CredentialEntity> markFavorite(String credentialId) async {
    final model = await _remoteDataSource.markFavorite(credentialId);
    return model.toEntity();
  }

  @override
  Future<CredentialEntity> unmarkFavorite(String credentialId) async {
    final model = await _remoteDataSource.unmarkFavorite(credentialId);
    return model.toEntity();
  }

  @override
  Future<CredentialEntity> toggleFavorite(String credentialId) async {
    final model = await _remoteDataSource.toggleFavorite(credentialId);
    return model.toEntity();
  }
}
