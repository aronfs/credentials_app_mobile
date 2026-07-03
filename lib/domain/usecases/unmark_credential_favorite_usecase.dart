import 'package:archive_secure/domain/entities/credential_entity.dart';
import 'package:archive_secure/domain/repositories/favorites_repository_contract.dart';

class UnmarkCredentialFavoriteUseCase {
  final FavoritesRepository _repository;

  UnmarkCredentialFavoriteUseCase({required FavoritesRepository repository})
      : _repository = repository;

  Future<CredentialEntity> call(String credentialId) async {
    return _repository.unmarkFavorite(credentialId);
  }
}
