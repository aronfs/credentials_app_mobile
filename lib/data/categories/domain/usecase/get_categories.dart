import 'package:archive_secure/data/categories/domain/entity/category.dart';
import 'package:archive_secure/data/categories/domain/repository/category_repository.dart';

class GetCategories {
  GetCategories({required this._repository});

  final CategoryRepository _repository;

  Future<List<Category>> call() async {
    return await _repository.getCategories();
  }
}
