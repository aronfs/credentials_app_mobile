import 'package:archive_secure/data/credentials/domain/entity/credential.dart';
import 'package:archive_secure/data/credentials/domain/repository/credential_repository.dart';

class GetCredentialById {
  GetCredentialById({required this._repository});

  final CredentialRepository _repository;

  Future<Credential> call(String id) async {
    return await _repository.getCredentialById(id);
  }
}
