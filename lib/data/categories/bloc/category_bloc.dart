import 'package:archive_secure/data/categories/bloc/category_event.dart';
import 'package:archive_secure/data/categories/bloc/category_state.dart';
import 'package:archive_secure/data/categories/domain/usecase/create_category.dart';
import 'package:archive_secure/data/categories/domain/usecase/delete_category.dart';
import 'package:archive_secure/data/categories/domain/usecase/get_categories.dart';
import 'package:archive_secure/data/categories/domain/usecase/update_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required this._getCategories,
    required this._createCategory,
    required this._updateCategory,
    required this._deleteCategory,
  }) : super(CategoryInitial()) {
    on<LoadCategories>(_onLoadCategories);
    on<CreateCategorySubmitted>(_onCreateCategory);
    on<UpdateCategorySubmitted>(_onUpdateCategory);
    on<DeleteCategorySubmitted>(_onDeleteCategory);
  }

  final GetCategories _getCategories;
  final CreateCategory _createCategory;
  final UpdateCategory _updateCategory;
  final DeleteCategory _deleteCategory;

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      final categories = await _getCategories.call();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoryFailure(_formatError(e)));
    }
  }

  Future<void> _onCreateCategory(
    CreateCategorySubmitted event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      await _createCategory.call(event.name, event.color, event.icon);
      final categories = await _getCategories.call();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoryFailure(_formatError(e)));
    }
  }

  Future<void> _onUpdateCategory(
    UpdateCategorySubmitted event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      await _updateCategory.call(
        event.id,
        name: event.name,
        color: event.color,
        icon: event.icon,
        isActive: event.isActive,
      );
      final categories = await _getCategories.call();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoryFailure(_formatError(e)));
    }
  }

  Future<void> _onDeleteCategory(
    DeleteCategorySubmitted event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      await _deleteCategory.call(event.id);
      final categories = await _getCategories.call();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoryFailure(_formatError(e)));
    }
  }

  String _formatError(Object e) {
    final message = e.toString();
    if (message.contains('403')) return 'No tienes permiso para esta acción';
    if (message.contains('404')) return 'Categoría no encontrada';
    if (message.contains('400') || message.contains('422')) {
      return 'Datos inválidos. Verifique la información.';
    }
    if (message.contains('SocketException') ||
        message.contains('Connection refused')) {
      return 'No se pudo conectar con el servidor';
    }
    return 'Error al procesar la solicitud. Intente de nuevo.';
  }
}
