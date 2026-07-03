import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String color;
  final String icon;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int totalCredentials;

  const Category({
    required this.id,
    required this.userId,
    required this.name,
    required this.color,
    required this.icon,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.totalCredentials = 0,
  });

  @override
  List<Object?> get props =>
      [id, userId, name, color, icon, isActive, createdAt, updatedAt, totalCredentials];
}
