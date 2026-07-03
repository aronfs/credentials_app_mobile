import 'package:equatable/equatable.dart';

class Credential extends Equatable {
  final String id;
  final String userId;
  final String serviceName;
  final String? loginEmail;
  final String? username;
  final String? categoryId;
  final String? notes;
  final List<String> tags;
  final int? strength;
  final bool isFavorite;
  final DateTime? lastUsedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Credential({
    required this.id,
    required this.userId,
    required this.serviceName,
    this.loginEmail,
    this.username,
    this.categoryId,
    this.notes,
    this.tags = const [],
    this.strength,
    this.isFavorite = false,
    this.lastUsedAt,
    required this.createdAt,
    required this.updatedAt,
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
        lastUsedAt,
        createdAt,
        updatedAt,
      ];
}
