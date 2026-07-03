import 'package:archive_secure/data/credentials/domain/entity/credential.dart';
import 'package:archive_secure/data/credentials/domain/repository/credential_repository.dart';

class CreateCredential {
  CreateCredential({required this._repository});

  final CredentialRepository _repository;

  Future<Credential> call({
    required String serviceName,
    String? loginEmail,
    String? username,
    required String password,
    String? categoryId,
    String? notes,
    List<String>? tags,
    int? strength,
  }) async {
    return await _repository.createCredential(
      serviceName: serviceName,
      loginEmail: loginEmail,
      username: username,
      password: password,
      categoryId: categoryId,
      notes: notes,
      tags: tags,
      strength: strength,
    );
  }
}
