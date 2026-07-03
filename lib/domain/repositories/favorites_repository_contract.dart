import 'package:archive_secure/domain/entities/credential_entity.dart';

class FavoriteCredentialsPageEntity {
  final List<CredentialEntity> items;
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  const FavoriteCredentialsPageEntity({
    required this.items,
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  bool get hasNextPage => page < totalPages;
}

abstract class FavoritesRepository {
  Future<FavoriteCredentialsPageEntity> getFavorites({
    int page = 1,
    int limit = 10,
    String? search,
  });
  Future<CredentialEntity> markFavorite(String credentialId);
  Future<CredentialEntity> unmarkFavorite(String credentialId);
  Future<CredentialEntity> toggleFavorite(String credentialId);
}
