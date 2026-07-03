import 'package:archive_secure/data/favorites/data/favorites_models.dart';
import 'package:archive_secure/data/favorites/data/favorites_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesState {
  final FavoritesStatus status;
  final List<FavoriteCredentialModel> items;
  final int currentPage;
  final int totalPages;
  final int total;
  final String? error;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.items = const [],
    this.currentPage = 1,
    this.totalPages = 0,
    this.total = 0,
    this.error,
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<FavoriteCredentialModel>? items,
    int? currentPage,
    int? totalPages,
    int? total,
    String? error,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      total: total ?? this.total,
      error: error,
    );
  }
}

enum FavoritesStatus { initial, loading, success, error, toggled }

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesService _service;
  String? _currentSearch;

  FavoritesCubit(this._service) : super(const FavoritesState());

  Future<void> load({int page = 1, String? search}) async {
    _currentSearch = search;
    emit(state.copyWith(status: FavoritesStatus.loading, currentPage: page));
    try {
      final result = await _service.getFavorites(page: page, search: search);
      emit(state.copyWith(
        status: FavoritesStatus.success,
        items: result.items,
        currentPage: result.pagination.page,
        totalPages: result.pagination.totalPages,
        total: result.pagination.total,
      ));
    } catch (e) {
      emit(state.copyWith(status: FavoritesStatus.error, error: 'Error al cargar favoritos'));
    }
  }

  Future<void> toggleFavorite(String id) async {
    try {
      await _service.toggleFavorite(id);
      await load(page: state.currentPage, search: _currentSearch);
    } catch (e) {
      emit(state.copyWith(status: FavoritesStatus.error, error: 'Error al cambiar favorito'));
    }
  }
}