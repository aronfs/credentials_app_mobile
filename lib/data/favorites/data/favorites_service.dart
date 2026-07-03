import 'package:archive_secure/core/security/token_storage.dart';
import 'package:archive_secure/data/favorites/data/favorites_models.dart';
import 'package:archive_secure/utils/api_endpoints.dart';
import 'package:dio/dio.dart';

class FavoritesService {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  FavoritesService(this._dio, this._tokenStorage);

  Future<String> _getToken() async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null) throw Exception('No authentication token');
    return token;
  }

  Future<FavoritesListModel> getFavorites({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    final token = await _getToken();
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
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return FavoritesListModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<void> toggleFavorite(String id) async {
    final token = await _getToken();
    await _dio.patch(
      ApiEndpoints.credentialToggleFavorite(id),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<void> markFavorite(String id) async {
    final token = await _getToken();
    await _dio.patch(
      ApiEndpoints.credentialFavorite(id),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<void> unmarkFavorite(String id) async {
    final token = await _getToken();
    await _dio.patch(
      ApiEndpoints.credentialUnfavorite(id),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}