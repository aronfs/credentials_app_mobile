import 'package:archive_secure/data/credentials/data/dto/credential_dto.dart';
import 'package:archive_secure/utils/api_endpoints.dart';
import 'package:dio/dio.dart';

abstract class CredentialApi {
  Future<List<CredentialResponseDto>> getCredentials(
    String token, {
    String? categoryId,
    bool? favorite,
  });
  Future<List<CredentialResponseDto>> searchCredentials(
      String token, String query);
  Future<CredentialResponseDto> getCredentialById(String token, String id);
  Future<PasswordResponseDto> getCredentialPassword(String token, String id);
  Future<CredentialResponseDto> createCredential(
      String token, CreateCredentialDto dto);
  Future<CredentialResponseDto> updateCredential(
      String token, String id, UpdateCredentialDto dto);
  Future<CredentialResponseDto> toggleFavorite(String token, String id);
  Future<void> deleteCredential(String token, String id);
}

class CredentialApiImpl implements CredentialApi {
  final Dio _dio;

  CredentialApiImpl(this._dio);

  Options _authOptions(String token) =>
      Options(headers: {'Authorization': 'Bearer $token'});

  List<CredentialResponseDto> _parseList(Map<String, dynamic> json) {
    final list = json['data'] as List;
    return list
        .map((e) => CredentialResponseDto.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CredentialResponseDto>> getCredentials(
    String token, {
    String? categoryId,
    bool? favorite,
  }) async {
    final queryParams = <String, dynamic>{};
    if (categoryId != null) queryParams['categoryId'] = categoryId;
    if (favorite != null) queryParams['favorite'] = favorite.toString();

    final response = await _dio.get(
      ApiEndpoints.credentials,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      options: _authOptions(token),
    );
    return _parseList(response.data);
  }

  @override
  Future<List<CredentialResponseDto>> searchCredentials(
      String token, String query) async {
    final response = await _dio.get(
      ApiEndpoints.credentialSearch,
      queryParameters: {'q': query},
      options: _authOptions(token),
    );
    return _parseList(response.data);
  }

  @override
  Future<CredentialResponseDto> getCredentialById(
      String token, String id) async {
    final response = await _dio.get(
      '${ApiEndpoints.credentials}/$id',
      options: _authOptions(token),
    );
    return CredentialResponseDto.fromJson(response.data);
  }

  @override
  Future<PasswordResponseDto> getCredentialPassword(
      String token, String id) async {
    final response = await _dio.get(
      '${ApiEndpoints.credentials}/$id/password',
      options: _authOptions(token),
    );
    return PasswordResponseDto.fromJson(response.data);
  }

  @override
  Future<CredentialResponseDto> createCredential(
      String token, CreateCredentialDto dto) async {
    final response = await _dio.post(
      ApiEndpoints.credentials,
      data: dto.toJson(),
      options: _authOptions(token),
    );
    return CredentialResponseDto.fromJson(response.data);
  }

  @override
  Future<CredentialResponseDto> updateCredential(
      String token, String id, UpdateCredentialDto dto) async {
    final response = await _dio.put(
      '${ApiEndpoints.credentials}/$id',
      data: dto.toJson(),
      options: _authOptions(token),
    );
    return CredentialResponseDto.fromJson(response.data);
  }

  @override
  Future<CredentialResponseDto> toggleFavorite(String token, String id) async {
    final response = await _dio.patch(
      ApiEndpoints.credentialToggleFavorite(id),
      options: _authOptions(token),
    );
    return CredentialResponseDto.fromJson(response.data);
  }

  @override
  Future<void> deleteCredential(String token, String id) async {
    await _dio.delete(
      '${ApiEndpoints.credentials}/$id',
      options: _authOptions(token),
    );
  }
}
