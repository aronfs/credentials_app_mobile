class FavoriteCredentialModel {
  final String id;
  final String serviceName;
  final String? loginEmail;
  final String? username;
  final String? categoryId;
  final bool isFavorite;
  final DateTime? favoriteAt;
  final DateTime updatedAt;

  FavoriteCredentialModel({
    required this.id,
    required this.serviceName,
    this.loginEmail,
    this.username,
    this.categoryId,
    required this.isFavorite,
    this.favoriteAt,
    required this.updatedAt,
  });

  factory FavoriteCredentialModel.fromJson(Map<String, dynamic> json) {
    return FavoriteCredentialModel(
      id: json['id'] as String,
      serviceName: json['serviceName'] as String,
      loginEmail: json['loginEmail'] as String?,
      username: json['username'] as String?,
      categoryId: json['categoryId'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? true,
      favoriteAt: json['favoriteAt'] != null
          ? DateTime.parse(json['favoriteAt'] as String)
          : null,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

class FavoritesPaginationModel {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  FavoritesPaginationModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory FavoritesPaginationModel.fromJson(Map<String, dynamic> json) {
    return FavoritesPaginationModel(
      page: json['page'] as int,
      limit: json['limit'] as int,
      total: json['total'] as int,
      totalPages: json['totalPages'] as int,
    );
  }
}

class FavoritesListModel {
  final List<FavoriteCredentialModel> items;
  final FavoritesPaginationModel pagination;

  FavoritesListModel({required this.items, required this.pagination});

  factory FavoritesListModel.fromJson(Map<String, dynamic> json) {
    return FavoritesListModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => FavoriteCredentialModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: FavoritesPaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }
}