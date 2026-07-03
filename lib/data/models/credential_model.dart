import 'package:archive_secure/domain/entities/credential_entity.dart';

class CredentialModel {
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

  const CredentialModel({
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

  factory CredentialModel.fromJson(Map<String, dynamic> json) {
    return CredentialModel(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      serviceName: json['serviceName'] as String,
      loginEmail: json['loginEmail'] as String?,
      username: json['username'] as String?,
      categoryId: json['categoryId'] as String?,
      notes: json['notes'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      strength: json['strength'] as int?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      favoriteAt: json['favoriteAt'] != null
          ? DateTime.tryParse(json['favoriteAt'] as String)
          : null,
      lastUsedAt: json['lastUsedAt'] != null
          ? DateTime.tryParse(json['lastUsedAt'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  CredentialEntity toEntity() {
    return CredentialEntity(
      id: id,
      userId: userId,
      serviceName: serviceName,
      loginEmail: loginEmail,
      username: username,
      categoryId: categoryId,
      notes: notes,
      tags: tags,
      strength: strength,
      isFavorite: isFavorite,
      favoriteAt: favoriteAt,
      lastUsedAt: lastUsedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
