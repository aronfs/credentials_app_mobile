import 'package:archive_secure/data/models/credential_model.dart';
import 'package:archive_secure/data/models/favorite_credentials_response_model.dart';
import 'package:archive_secure/utils/api_endpoints.dart';
import 'package:dio/dio.dart';

abstract class FavoritesRemoteDataSource {
  Future<FavoriteCredentialsResponseModel> getFavorites({
    int page = 1,
    int limit = 10,
    String? search,
  });

  Future<CredentialModel> markFavorite(String credentialId);
  Future<CredentialModel> unmarkFavorite(String credentialId);
  Future<CredentialModel> toggleFavorite(String credentialId);
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final Dio _dio;

  FavoritesRemoteDataSourceImpl(this._dio);

  @override
  Future<FavoriteCredentialsResponseModel> getFavorites({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }
    final response = await _dio.get(
      ApiEndpoints.credentialFavoritesList,
      queryParameters: queryParams,
    );
    final data = response.data;
    if (data is Map<String, dynamic> && data['data'] is Map<String, dynamic>) {
      return FavoriteCredentialsResponseModel.fromJson(
          data['data'] as Map<String, dynamic>);
    }
    throw Exception('Formato de respuesta inválido');
  }

  @override
  Future<CredentialModel> markFavorite(String credentialId) async {
    final response = await _dio.patch(
      ApiEndpoints.credentialFavorite(credentialId),
    );
    final data = response.data;
    if (data is Map<String, dynamic> && data['data'] is Map<String, dynamic>) {
      return CredentialModel.fromJson(data['data'] as Map<String, dynamic>);
    }
    throw Exception('Formato de respuesta inválido');
  }

  @override
  Future<CredentialModel> unmarkFavorite(String credentialId) async {
    final response = await _dio.patch(
      ApiEndpoints.credentialUnfavorite(credentialId),
    );
    final data = response.data;
    if (data is Map<String, dynamic> && data['data'] is Map<String, dynamic>) {
      return CredentialModel.fromJson(data['data'] as Map<String, dynamic>);
    }
    throw Exception('Formato de respuesta inválido');
  }

  @override
  Future<CredentialModel> toggleFavorite(String credentialId) async {
    final response = await _dio.patch(
      ApiEndpoints.credentialToggleFavorite(credentialId),
    );
    final data = response.data;
    if (data is Map<String, dynamic> && data['data'] is Map<String, dynamic>) {
      return CredentialModel.fromJson(data['data'] as Map<String, dynamic>);
    }
    throw Exception('Formato de respuesta inválido');
  }
}
