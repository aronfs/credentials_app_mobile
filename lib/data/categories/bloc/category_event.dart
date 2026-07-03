import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategories extends CategoryEvent {}

class CreateCategorySubmitted extends CategoryEvent {
  final String name;
  final String color;
  final String icon;

  const CreateCategorySubmitted({
    required this.name,
    required this.color,
    required this.icon,
  });

  @override
  List<Object?> get props => [name, color, icon];
}

class UpdateCategorySubmitted extends CategoryEvent {
  final String id;
  final String? name;
  final String? color;
  final String? icon;
  final bool? isActive;

  const UpdateCategorySubmitted({
    required this.id,
    this.name,
    this.color,
    this.icon,
    this.isActive,
  });

  @override
  List<Object?> get props => [id, name, color, icon, isActive];
}

class DeleteCategorySubmitted extends CategoryEvent {
  final String id;

  const DeleteCategorySubmitted({required this.id});

  @override
  List<Object?> get props => [id];
}
