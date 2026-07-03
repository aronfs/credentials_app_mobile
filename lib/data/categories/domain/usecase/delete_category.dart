import 'package:archive_secure/data/categories/domain/repository/category_repository.dart';

class DeleteCategory {
  DeleteCategory({required this._repository});

  final CategoryRepository _repository;

  Future<void> call(String id) async {
    return await _repository.deleteCategory(id);
  }
}
