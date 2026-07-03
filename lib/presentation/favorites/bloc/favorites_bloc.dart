import 'dart:async';

import 'package:archive_secure/domain/entities/credential_entity.dart';
import 'package:archive_secure/domain/usecases/get_favorite_credentials_usecase.dart';
import 'package:archive_secure/domain/usecases/toggle_credential_favorite_usecase.dart';
import 'package:archive_secure/domain/usecases/unmark_credential_favorite_usecase.dart';
import 'package:archive_secure/presentation/favorites/bloc/favorites_event.dart';
import 'package:archive_secure/presentation/favorites/bloc/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoriteCredentialsUseCase _getFavoritesUseCase;
  final ToggleCredentialFavoriteUseCase _toggleFavoriteUseCase;
  final UnmarkCredentialFavoriteUseCase _unmarkFavoriteUseCase;
  Timer? _debounce;

  FavoritesBloc({
    required GetFavoriteCredentialsUseCase getFavoriteCredentialsUseCase,
    required ToggleCredentialFavoriteUseCase toggleCredentialFavoriteUseCase,
    required UnmarkCredentialFavoriteUseCase unmarkCredentialFavoriteUseCase,
  })  : _getFavoritesUseCase = getFavoriteCredentialsUseCase,
        _toggleFavoriteUseCase = toggleCredentialFavoriteUseCase,
        _unmarkFavoriteUseCase = unmarkCredentialFavoriteUseCase,
        super(const FavoritesInitial()) {
    on<FavoritesRequested>(_onFavoritesRequested);
    on<FavoritesRefreshed>(_onFavoritesRefreshed);
    on<FavoritesSearchChanged>(_onFavoritesSearchChanged);
    on<FavoritesNextPageRequested>(_onFavoritesNextPageRequested);
    on<FavoriteToggled>(_onFavoriteToggled);
    on<FavoriteRemoved>(_onFavoriteRemoved);
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  Future<void> _onFavoritesRequested(
    FavoritesRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());
    await _fetchFavorites(emit, page: event.page);
  }

  Future<void> _onFavoritesRefreshed(
    FavoritesRefreshed event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    final search = currentState is FavoritesLoaded
        ? currentState.currentSearch
        : currentState is FavoritesLoadingMore
            ? currentState.currentSearch
            : null;
    await _fetchFavorites(emit, page: 1, search: search);
  }

  Future<void> _onFavoritesSearchChanged(
    FavoritesSearchChanged event,
    Emitter<FavoritesState> emit,
  ) async {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      emit(const FavoritesLoading());
      await _fetchFavorites(emit, page: 1, search: event.query);
    });
  }

  Future<void> _onFavoritesNextPageRequested(
    FavoritesNextPageRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    if (currentState is FavoritesLoaded && currentState.hasNextPage) {
      final nextPage = currentState.currentPage + 1;
      emit(FavoritesLoadingMore(
        currentItems: currentState.items,
        currentPage: currentState.currentPage,
        totalPages: currentState.totalPages,
        total: currentState.total,
        currentSearch: currentState.currentSearch,
      ));
      try {
        final result = await _getFavoritesUseCase.call(
          page: nextPage,
          search: currentState.currentSearch,
        );
        final allItems = [
          ...currentState.items,
          ...result.items,
        ];
        emit(FavoritesLoaded(
          items: allItems,
          currentPage: result.page,
          totalPages: result.totalPages,
          total: result.total,
          currentSearch: currentState.currentSearch,
        ));
      } catch (e) {
        emit(FavoritesFailure(_formatError(e)));
      }
    }
  }

  Future<void> _onFavoriteToggled(
    FavoriteToggled event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    if (currentState is FavoritesLoaded) {
      _updateListAfterToggle(emit, currentState, event.credentialId);
    }
  }

  Future<void> _onFavoriteRemoved(
    FavoriteRemoved event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    if (currentState is FavoritesLoaded) {
      final updatedItems = currentState.items
          .where((item) => item.id != event.credentialId)
          .toList();
      emit(FavoritesLoaded(
        items: updatedItems,
        currentPage: currentState.currentPage,
        totalPages: currentState.totalPages,
        total: currentState.total - 1,
        currentSearch: currentState.currentSearch,
      ));
      try {
        await _unmarkFavoriteUseCase.call(event.credentialId);
      } catch (e) {
        emit(FavoritesFailure(_formatError(e)));
      }
    }
  }

  Future<void> _updateListAfterToggle(
    Emitter<FavoritesState> emit,
    FavoritesLoaded currentState,
    String credentialId,
  ) async {
    final index = currentState.items.indexWhere((c) => c.id == credentialId);
    if (index == -1) return;

    final updatedCredential = currentState.items[index];
    final toggledCredential = CredentialEntity(
      id: updatedCredential.id,
      userId: updatedCredential.userId,
      serviceName: updatedCredential.serviceName,
      loginEmail: updatedCredential.loginEmail,
      username: updatedCredential.username,
      categoryId: updatedCredential.categoryId,
      notes: updatedCredential.notes,
      tags: updatedCredential.tags,
      strength: updatedCredential.strength,
      isFavorite: !updatedCredential.isFavorite,
      favoriteAt: updatedCredential.favoriteAt,
      lastUsedAt: updatedCredential.lastUsedAt,
      createdAt: updatedCredential.createdAt,
      updatedAt: updatedCredential.updatedAt,
    );

    final updatedList = [...currentState.items];
    updatedList[index] = toggledCredential;

    emit(FavoritesLoaded(
      items: updatedList,
      currentPage: currentState.currentPage,
      totalPages: currentState.totalPages,
      total: currentState.total,
      currentSearch: currentState.currentSearch,
    ));

    try {
      await _toggleFavoriteUseCase.call(credentialId);
    } catch (e) {
      emit(FavoritesLoaded(
        items: currentState.items,
        currentPage: currentState.currentPage,
        totalPages: currentState.totalPages,
        total: currentState.total,
        currentSearch: currentState.currentSearch,
      ));
      emit(FavoritesActionFailure(_formatError(e)));
    }
  }

  Future<void> _fetchFavorites(
    Emitter<FavoritesState> emit, {
    int page = 1,
    String? search,
  }) async {
    try {
      final result = await _getFavoritesUseCase.call(
        page: page,
        search: search,
      );
      emit(FavoritesLoaded(
        items: result.items,
        currentPage: result.page,
        totalPages: result.totalPages,
        total: result.total,
        currentSearch: search,
      ));
    } catch (e) {
      emit(FavoritesFailure(_formatError(e)));
    }
  }

  String _formatError(Object e) {
    final message = e.toString();
    if (message.contains('403')) return 'No tienes permiso para esta acción';
    if (message.contains('404')) return 'Favoritos no encontrados';
    if (message.contains('SocketException') ||
        message.contains('Connection refused')) {
      return 'No se pudo conectar con el servidor';
    }
    return 'Error al cargar favoritos. Intente de nuevo.';
  }
}
