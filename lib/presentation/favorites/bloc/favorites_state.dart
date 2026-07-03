import 'package:archive_secure/domain/entities/credential_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<CredentialEntity> items;
  final int currentPage;
  final int totalPages;
  final int total;
  final String? currentSearch;

  const FavoritesLoaded({
    required this.items,
    this.currentPage = 1,
    this.totalPages = 0,
    this.total = 0,
    this.currentSearch,
  });

  bool get hasNextPage => currentPage < totalPages;

  @override
  List<Object?> get props => [items, currentPage, totalPages, total, currentSearch];
}

class FavoritesLoadingMore extends FavoritesState {
  final List<CredentialEntity> currentItems;
  final int currentPage;
  final int totalPages;
  final int total;
  final String? currentSearch;

  const FavoritesLoadingMore({
    required this.currentItems,
    this.currentPage = 1,
    this.totalPages = 0,
    this.total = 0,
    this.currentSearch,
  });

  @override
  List<Object?> get props => [
        currentItems,
        currentPage,
        totalPages,
        total,
        currentSearch,
      ];
}

class FavoritesFailure extends FavoritesState {
  final String error;

  const FavoritesFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class FavoritesActionFailure extends FavoritesState {
  final String error;

  const FavoritesActionFailure(this.error);

  @override
  List<Object?> get props => [error];
}
