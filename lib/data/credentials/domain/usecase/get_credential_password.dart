import 'package:archive_secure/data/credentials/domain/repository/credential_repository.dart';

class GetCredentialPassword {
  GetCredentialPassword({required this._repository});

  final CredentialRepository _repository;

  Future<CredentialWithPassword> call(String id) async {
    return await _repository.getCredentialPassword(id);
  }
}
