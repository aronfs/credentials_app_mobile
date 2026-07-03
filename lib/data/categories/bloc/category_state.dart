import 'package:archive_secure/data/categories/domain/entity/category.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoriesLoaded extends CategoryState {
  final List<Category> categories;

  const CategoriesLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategorySuccess extends CategoryState {
  final String message;

  const CategorySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CategoryFailure extends CategoryState {
  final String error;

  const CategoryFailure(this.error);

  @override
  List<Object?> get props => [error];
}
