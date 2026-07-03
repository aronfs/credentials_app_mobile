import 'package:archive_secure/data/credentials/domain/entity/credential.dart';
import 'package:archive_secure/data/credentials/domain/repository/credential_repository.dart';

class GetCredentials {
  GetCredentials({required this._repository});

  final CredentialRepository _repository;

  Future<List<Credential>> call({String? categoryId, bool? favorite}) async {
    return await _repository.getCredentials(
      categoryId: categoryId,
      favorite: favorite,
    );
  }
}
