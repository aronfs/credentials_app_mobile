import 'package:archive_secure/domain/entities/dashboard_entity.dart';

class DashboardSummaryModel {
  final int totalCredentials;
  final int totalCategories;
  final int totalFavorites;
  final int totalRecentCredentials;
  final int averageSecurityScore;

  const DashboardSummaryModel({
    required this.totalCredentials,
    required this.totalCategories,
    required this.totalFavorites,
    required this.totalRecentCredentials,
    required this.averageSecurityScore,
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    return DashboardSummaryModel(
      totalCredentials: (json['totalCredentials'] as num?)?.toInt() ?? 0,
      totalCategories: (json['totalCategories'] as num?)?.toInt() ?? 0,
      totalFavorites: (json['totalFavorites'] as num?)?.toInt() ?? 0,
      totalRecentCredentials:
          (json['totalRecentCredentials'] as num?)?.toInt() ?? 0,
      averageSecurityScore:
          (json['averageSecurityScore'] as num?)?.toInt() ?? 0,
    );
  }

  DashboardSummaryEntity toEntity() {
    return DashboardSummaryEntity(
      totalCredentials: totalCredentials,
      totalCategories: totalCategories,
      totalFavorites: totalFavorites,
      totalRecentCredentials: totalRecentCredentials,
      averageSecurityScore: averageSecurityScore,
    );
  }
}

class DashboardCredentialModel {
  final String id;
  final String serviceName;
  final String? loginEmail;
  final String? username;
  final String? categoryId;
  final bool isFavorite;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const DashboardCredentialModel({
    required this.id,
    required this.serviceName,
    this.loginEmail,
    this.username,
    this.categoryId,
    this.isFavorite = false,
    this.createdAt,
    this.updatedAt,
  });

  factory DashboardCredentialModel.fromJson(Map<String, dynamic> json) {
    return DashboardCredentialModel(
      id: json['id'] as String? ?? '',
      serviceName: json['serviceName'] as String? ?? '',
      loginEmail: json['loginEmail'] as String?,
      username: json['username'] as String?,
      categoryId: json['categoryId'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  DashboardCredentialEntity toEntity() {
    return DashboardCredentialEntity(
      id: id,
      serviceName: serviceName,
      loginEmail: loginEmail,
      username: username,
      categoryId: categoryId,
      isFavorite: isFavorite,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class DashboardCategoryModel {
  final String id;
  final String name;
  final String color;
  final String icon;
  final int totalCredentials;

  const DashboardCategoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.totalCredentials,
  });

  factory DashboardCategoryModel.fromJson(Map<String, dynamic> json) {
    return DashboardCategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      color: json['color'] as String? ?? '#6366F1',
      icon: json['icon'] as String? ?? 'folder',
      totalCredentials: (json['totalCredentials'] as num?)?.toInt() ?? 0,
    );
  }

  DashboardCategoryEntity toEntity() {
    return DashboardCategoryEntity(
      id: id,
      name: name,
      color: color,
      icon: icon,
      totalCredentials: totalCredentials,
    );
  }
}

class DashboardSecurityAlertModel {
  final String? id;
  final String? type;
  final String? title;
  final String? message;
  final String? severity;
  final DateTime? createdAt;

  const DashboardSecurityAlertModel({
    this.id,
    this.type,
    this.title,
    this.message,
    this.severity,
    this.createdAt,
  });

  factory DashboardSecurityAlertModel.fromJson(Map<String, dynamic> json) {
    return DashboardSecurityAlertModel(
      id: json['id'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      severity: json['severity'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
    );
  }

  DashboardSecurityAlertEntity toEntity() {
    return DashboardSecurityAlertEntity(
      id: id,
      type: type,
      title: title,
      message: message,
      severity: severity,
      createdAt: createdAt,
    );
  }
}

class DashboardModel {
  final DashboardSummaryModel summary;
  final List<DashboardCredentialModel> recentCredentials;
  final List<DashboardCredentialModel> favoriteCredentials;
  final List<DashboardCategoryModel> topCategories;
  final List<DashboardSecurityAlertModel> securityAlerts;

  const DashboardModel({
    required this.summary,
    required this.recentCredentials,
    required this.favoriteCredentials,
    required this.topCategories,
    required this.securityAlerts,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      summary:
          DashboardSummaryModel.fromJson(json['summary'] as Map<String, dynamic>? ?? {}),
      recentCredentials: _parseList(json['recentCredentials']),
      favoriteCredentials: _parseList(json['favoriteCredentials']),
      topCategories: _parseCategoryList(json['topCategories']),
      securityAlerts: _parseAlertList(json['securityAlerts']),
    );
  }

  static List<DashboardCredentialModel> _parseList(dynamic list) {
    if (list == null || list is! List) return [];
    return list
        .map((e) => DashboardCredentialModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static List<DashboardCategoryModel> _parseCategoryList(dynamic list) {
    if (list == null || list is! List) return [];
    return list
        .map((e) => DashboardCategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static List<DashboardSecurityAlertModel> _parseAlertList(dynamic list) {
    if (list == null || list is! List) return [];
    return list
        .map((e) => DashboardSecurityAlertModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  DashboardEntity toEntity() {
    return DashboardEntity(
      summary: summary.toEntity(),
      recentCredentials:
          recentCredentials.map((e) => e.toEntity()).toList(),
      favoriteCredentials:
          favoriteCredentials.map((e) => e.toEntity()).toList(),
      topCategories: topCategories.map((e) => e.toEntity()).toList(),
      securityAlerts: securityAlerts.map((e) => e.toEntity()).toList(),
    );
  }
}
