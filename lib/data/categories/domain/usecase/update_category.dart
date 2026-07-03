import 'package:archive_secure/data/categories/domain/entity/category.dart';
import 'package:archive_secure/data/categories/domain/repository/category_repository.dart';

class UpdateCategory {
  UpdateCategory({required this._repository});

  final CategoryRepository _repository;

  Future<Category> call(
    String id, {
    String? name,
    String? color,
    String? icon,
    bool? isActive,
  }) async {
    return await _repository.updateCategory(
      id,
      name: name,
      color: color,
      icon: icon,
      isActive: isActive,
    );
  }
}
