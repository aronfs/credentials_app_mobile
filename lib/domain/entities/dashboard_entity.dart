import 'package:equatable/equatable.dart';

class DashboardEntity extends Equatable {
  final DashboardSummaryEntity summary;
  final List<DashboardCredentialEntity> recentCredentials;
  final List<DashboardCredentialEntity> favoriteCredentials;
  final List<DashboardCategoryEntity> topCategories;
  final List<DashboardSecurityAlertEntity> securityAlerts;

  const DashboardEntity({
    required this.summary,
    required this.recentCredentials,
    required this.favoriteCredentials,
    required this.topCategories,
    required this.securityAlerts,
  });

  @override
  List<Object?> get props => [
        summary,
        recentCredentials,
        favoriteCredentials,
        topCategories,
        securityAlerts,
      ];
}

class DashboardSummaryEntity extends Equatable {
  final int totalCredentials;
  final int totalCategories;
  final int totalFavorites;
  final int totalRecentCredentials;
  final int averageSecurityScore;

  const DashboardSummaryEntity({
    required this.totalCredentials,
    required this.totalCategories,
    required this.totalFavorites,
    required this.totalRecentCredentials,
    required this.averageSecurityScore,
  });

  @override
  List<Object?> get props => [
        totalCredentials,
        totalCategories,
        totalFavorites,
        totalRecentCredentials,
        averageSecurityScore,
      ];
}

class DashboardCredentialEntity extends Equatable {
  final String id;
  final String serviceName;
  final String? loginEmail;
  final String? username;
  final String? categoryId;
  final bool isFavorite;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const DashboardCredentialEntity({
    required this.id,
    required this.serviceName,
    this.loginEmail,
    this.username,
    this.categoryId,
    this.isFavorite = false,
    this.createdAt,
    this.updatedAt,
  });

  String get displayIdentifier => loginEmail ?? username ?? 'Sin identificador';

  @override
  List<Object?> get props => [
        id,
        serviceName,
        loginEmail,
        username,
        categoryId,
        isFavorite,
        createdAt,
        updatedAt,
      ];
}

class DashboardCategoryEntity extends Equatable {
  final String id;
  final String name;
  final String color;
  final String icon;
  final int totalCredentials;

  const DashboardCategoryEntity({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.totalCredentials,
  });

  @override
  List<Object?> get props => [id, name, color, icon, totalCredentials];
}

class DashboardSecurityAlertEntity extends Equatable {
  final String? id;
  final String? type;
  final String? title;
  final String? message;
  final String? severity;
  final DateTime? createdAt;

  const DashboardSecurityAlertEntity({
    this.id,
    this.type,
    this.title,
    this.message,
    this.severity,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, type, title, message, severity, createdAt];
}
