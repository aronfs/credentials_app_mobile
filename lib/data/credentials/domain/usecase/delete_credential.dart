import 'package:archive_secure/data/credentials/domain/repository/credential_repository.dart';

class DeleteCredential {
  DeleteCredential({required this._repository});

  final CredentialRepository _repository;

  Future<void> call(String id) async {
    return await _repository.deleteCredential(id);
  }
}
