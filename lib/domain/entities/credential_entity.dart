import 'package:equatable/equatable.dart';

class CredentialEntity extends Equatable {
  final String id;
  final String? userId;
  final String serviceName;
  final String? loginEmail;
  final String? username;
  final String? categoryId;
  final String? notes;
  final List<String> tags;
  final int? strength;
  final bool isFavorite;
  final DateTime? favoriteAt;
  final DateTime? lastUsedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CredentialEntity({
    required this.id,
    this.userId,
    required this.serviceName,
    this.loginEmail,
    this.username,
    this.categoryId,
    this.notes,
    this.tags = const [],
    this.strength,
    this.isFavorite = false,
    this.favoriteAt,
    this.lastUsedAt,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        serviceName,
        loginEmail,
        username,
        categoryId,
        notes,
        tags,
        strength,
        isFavorite,
        favoriteAt,
        lastUsedAt,
        createdAt,
        updatedAt,
      ];
}
