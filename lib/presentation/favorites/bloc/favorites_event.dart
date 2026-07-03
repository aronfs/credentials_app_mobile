import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FavoritesRequested extends FavoritesEvent {
  final int page;

  const FavoritesRequested({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class FavoritesRefreshed extends FavoritesEvent {
  const FavoritesRefreshed();
}

class FavoritesSearchChanged extends FavoritesEvent {
  final String query;

  const FavoritesSearchChanged({required this.query});

  @override
  List<Object?> get props => [query];
}

class FavoritesNextPageRequested extends FavoritesEvent {
  const FavoritesNextPageRequested();
}

class FavoriteToggled extends FavoritesEvent {
  final String credentialId;

  const FavoriteToggled({required this.credentialId});

  @override
  List<Object?> get props => [credentialId];
}

class FavoriteRemoved extends FavoritesEvent {
  final String credentialId;

  const FavoriteRemoved({required this.credentialId});

  @override
  List<Object?> get props => [credentialId];
}
