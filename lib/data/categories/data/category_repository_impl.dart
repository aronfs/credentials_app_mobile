import 'package:archive_secure/core/security/token_storage.dart';
import 'package:archive_secure/data/categories/data/dto/category_dto.dart';
import 'package:archive_secure/data/categories/data/source/network/api.dart';
import 'package:archive_secure/data/categories/domain/entity/category.dart';
import 'package:archive_secure/data/categories/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryApi _api;
  final TokenStorage _tokenStorage;

  CategoryRepositoryImpl(this._api, this._tokenStorage);

  Future<String> _getToken() async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null) throw Exception('No authentication token');
    return token;
  }

  @override
  Future<List<Category>> getCategories() async {
    final token = await _getToken();
    final dtos = await _api.getCategories(token);
    return dtos.map(_toEntity).toList();
  }

  @override
  Future<Category> createCategory(
      String name, String color, String icon) async {
    final token = await _getToken();
    final dto = CreateCategoryDto(name: name, color: color, icon: icon);
    final response = await _api.createCategory(token, dto);
    return _toEntity(response);
  }

  @override
  Future<Category> updateCategory(
    String id, {
    String? name,
    String? color,
    String? icon,
    bool? isActive,
  }) async {
    final token = await _getToken();
    final dto = UpdateCategoryDto(
      name: name,
      color: color,
      icon: icon,
      isActive: isActive,
    );
    final response = await _api.updateCategory(token, id, dto);
    return _toEntity(response);
  }

  @override
  Future<void> deleteCategory(String id) async {
    final token = await _getToken();
    await _api.deleteCategory(token, id);
  }

  Category _toEntity(CategoryResponseDto dto) {
    return Category(
      id: dto.id,
      userId: dto.userId,
      name: dto.name,
      color: dto.color,
      icon: dto.icon,
      isActive: dto.isActive,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      totalCredentials: dto.totalCredentials,
    );
  }
}
