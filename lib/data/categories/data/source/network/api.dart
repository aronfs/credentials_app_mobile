import 'package:archive_secure/data/categories/data/dto/category_dto.dart';
import 'package:archive_secure/utils/api_endpoints.dart';
import 'package:dio/dio.dart';

abstract class CategoryApi {
  Future<List<CategoryResponseDto>> getCategories(String token);
  Future<CategoryResponseDto> createCategory(
      String token, CreateCategoryDto dto);
  Future<CategoryResponseDto> updateCategory(
      String token, String id, UpdateCategoryDto dto);
  Future<void> deleteCategory(String token, String id);
}

class CategoryApiImpl implements CategoryApi {
  final Dio _dio;

  CategoryApiImpl(this._dio);

  @override
  Future<List<CategoryResponseDto>> getCategories(String token) async {
    final response = await _dio.get(
      ApiEndpoints.categories,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    final list = response.data['data'] as List;
    return list
        .map((e) => CategoryResponseDto.fromJson({'data': e}))
        .toList();
  }

  @override
  Future<CategoryResponseDto> createCategory(
      String token, CreateCategoryDto dto) async {
    final response = await _dio.post(
      ApiEndpoints.categories,
      data: dto.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return CategoryResponseDto.fromJson(response.data);
  }

  @override
  Future<CategoryResponseDto> updateCategory(
      String token, String id, UpdateCategoryDto dto) async {
    final response = await _dio.put(
      '${ApiEndpoints.categories}/$id',
      data: dto.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return CategoryResponseDto.fromJson(response.data);
  }

  @override
  Future<void> deleteCategory(String token, String id) async {
    await _dio.delete(
      '${ApiEndpoints.categories}/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
