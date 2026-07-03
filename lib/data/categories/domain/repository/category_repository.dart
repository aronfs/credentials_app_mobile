import 'package:archive_secure/data/categories/domain/entity/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<Category> createCategory(String name, String color, String icon);
  Future<Category> updateCategory(
    String id, {
    String? name,
    String? color,
    String? icon,
    bool? isActive,
  });
  Future<void> deleteCategory(String id);
}
