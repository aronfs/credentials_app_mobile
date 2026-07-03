import 'package:archive_secure/domain/repositories/favorites_repository_contract.dart';

class GetFavoriteCredentialsUseCase {
  final FavoritesRepository _repository;

  GetFavoriteCredentialsUseCase({required FavoritesRepository repository})
      : _repository = repository;

  Future<FavoriteCredentialsPageEntity> call({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    return _repository.getFavorites(page: page, limit: limit, search: search);
  }
}
