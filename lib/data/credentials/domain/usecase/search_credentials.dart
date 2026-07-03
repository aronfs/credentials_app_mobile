import 'package:archive_secure/data/credentials/domain/entity/credential.dart';
import 'package:archive_secure/data/credentials/domain/repository/credential_repository.dart';

class SearchCredentials {
  SearchCredentials({required this._repository});

  final CredentialRepository _repository;

  Future<List<Credential>> call(String query) async {
    return await _repository.searchCredentials(query);
  }
}
