import 'package:archive_secure/data/credentials/domain/entity/credential.dart';

class CredentialWithPassword {
  final Credential credential;
  final String password;

  const CredentialWithPassword({
    required this.credential,
    required this.password,
  });
}

abstract class CredentialRepository {
  Future<List<Credential>> getCredentials({String? categoryId, bool? favorite});
  Future<List<Credential>> searchCredentials(String query);
  Future<Credential> getCredentialById(String id);
  Future<CredentialWithPassword> getCredentialPassword(String id);
  Future<Credential> createCredential({
    required String serviceName,
    String? loginEmail,
    String? username,
    required String password,
    String? categoryId,
    String? notes,
    List<String>? tags,
    int? strength,
  });
  Future<Credential> updateCredential(
    String id, {
    String? serviceName,
    String? loginEmail,
    String? username,
    String? password,
    String? categoryId,
    String? notes,
    List<String>? tags,
    int? strength,
  });
  Future<Credential> toggleFavorite(String id);
  Future<void> deleteCredential(String id);
}
