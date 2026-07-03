import 'package:archive_secure/data/categories/domain/entity/category.dart';
import 'package:archive_secure/data/categories/domain/repository/category_repository.dart';

class CreateCategory {
  CreateCategory({required this._repository});

  final CategoryRepository _repository;

  Future<Category> call(String name, String color, String icon) async {
    return await _repository.createCategory(name, color, icon);
  }
}
