import 'package:archive_secure/core/security/token_storage.dart';
import 'package:archive_secure/data/credentials/data/dto/credential_dto.dart';
import 'package:archive_secure/data/credentials/data/source/network/api.dart';
import 'package:archive_secure/data/credentials/domain/entity/credential.dart';
import 'package:archive_secure/data/credentials/domain/repository/credential_repository.dart';

class CredentialRepositoryImpl implements CredentialRepository {
  final CredentialApi _api;
  final TokenStorage _tokenStorage;

  CredentialRepositoryImpl(this._api, this._tokenStorage);

  Future<String> _getToken() async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null) throw Exception('No authentication token');
    return token;
  }

  Credential _toEntity(CredentialResponseDto dto) {
    return Credential(
      id: dto.id,
      userId: dto.userId,
      serviceName: dto.serviceName,
      loginEmail: dto.loginEmail,
      username: dto.username,
      categoryId: dto.categoryId,
      notes: dto.notes,
      tags: dto.tags,
      strength: dto.strength,
      isFavorite: dto.isFavorite,
      lastUsedAt: dto.lastUsedAt,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  @override
  Future<List<Credential>> getCredentials({
    String? categoryId,
    bool? favorite,
  }) async {
    final token = await _getToken();
    final dtos = await _api.getCredentials(
      token,
      categoryId: categoryId,
      favorite: favorite,
    );
    return dtos.map(_toEntity).toList();
  }

  @override
  Future<List<Credential>> searchCredentials(String query) async {
    final token = await _getToken();
    final dtos = await _api.searchCredentials(token, query);
    return dtos.map(_toEntity).toList();
  }

  @override
  Future<Credential> getCredentialById(String id) async {
    final token = await _getToken();
    final dto = await _api.getCredentialById(token, id);
    return _toEntity(dto);
  }

  @override
  Future<CredentialWithPassword> getCredentialPassword(String id) async {
    final token = await _getToken();
    final credDto = await _api.getCredentialById(token, id);
    final passDto = await _api.getCredentialPassword(token, id);
    return CredentialWithPassword(
      credential: _toEntity(credDto),
      password: passDto.password,
    );
  }

  @override
  Future<Credential> createCredential({
    required String serviceName,
    String? loginEmail,
    String? username,
    required String password,
    String? categoryId,
    String? notes,
    List<String>? tags,
    int? strength,
  }) async {
    final token = await _getToken();
    final requestDto = CreateCredentialDto(
      serviceName: serviceName,
      loginEmail: loginEmail,
      username: username,
      password: password,
      categoryId: categoryId,
      notes: notes,
      tags: tags,
      strength: strength,
    );
    final responseDto = await _api.createCredential(token, requestDto);
    return _toEntity(responseDto);
  }

  @override
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
  }) async {
    final token = await _getToken();
    final requestDto = UpdateCredentialDto(
      serviceName: serviceName,
      loginEmail: loginEmail,
      username: username,
      password: password,
      categoryId: categoryId,
      notes: notes,
      tags: tags,
      strength: strength,
    );
    final responseDto = await _api.updateCredential(token, id, requestDto);
    return _toEntity(responseDto);
  }

  @override
  Future<Credential> toggleFavorite(String id) async {
    final token = await _getToken();
    final dto = await _api.toggleFavorite(token, id);
    return _toEntity(dto);
  }

  @override
  Future<void> deleteCredential(String id) async {
    final token = await _getToken();
    await _api.deleteCredential(token, id);
  }
}
