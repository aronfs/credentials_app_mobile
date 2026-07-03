class DashboardSummaryModel {
  final int totalCredentials;
  final int totalCategories;
  final int totalFavorites;
  final int totalRecentCredentials;
  final int averageSecurityScore;

  DashboardSummaryModel({
    required this.totalCredentials,
    required this.totalCategories,
    required this.totalFavorites,
    required this.totalRecentCredentials,
    required this.averageSecurityScore,
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    return DashboardSummaryModel(
      totalCredentials: json['totalCredentials'] as int,
      totalCategories: json['totalCategories'] as int,
      totalFavorites: json['totalFavorites'] as int,
      totalRecentCredentials: json['totalRecentCredentials'] as int,
      averageSecurityScore: json['averageSecurityScore'] as int,
    );
  }
}

class DashboardRecentCredentialModel {
  final String id;
  final String serviceName;
  final String? loginEmail;
  final String? username;
  final String? categoryId;
  final bool isFavorite;
  final DateTime createdAt;

  DashboardRecentCredentialModel({
    required this.id,
    required this.serviceName,
    this.loginEmail,
    this.username,
    this.categoryId,
    required this.isFavorite,
    required this.createdAt,
  });

  factory DashboardRecentCredentialModel.fromJson(Map<String, dynamic> json) {
    return DashboardRecentCredentialModel(
      id: json['id'] as String,
      serviceName: json['serviceName'] as String,
      loginEmail: json['loginEmail'] as String?,
      username: json['username'] as String?,
      categoryId: json['categoryId'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

class DashboardCategoryModel {
  final String id;
  final String name;
  final String color;
  final String icon;
  final int totalCredentials;

  DashboardCategoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.totalCredentials,
  });

  factory DashboardCategoryModel.fromJson(Map<String, dynamic> json) {
    return DashboardCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String,
      icon: json['icon'] as String,
      totalCredentials: json['totalCredentials'] as int,
    );
  }
}

class DashboardFavoriteCredentialModel {
  final String id;
  final String serviceName;
  final String? loginEmail;
  final String? username;
  final String? categoryId;
  final DateTime updatedAt;

  DashboardFavoriteCredentialModel({
    required this.id,
    required this.serviceName,
    this.loginEmail,
    this.username,
    this.categoryId,
    required this.updatedAt,
  });

  factory DashboardFavoriteCredentialModel.fromJson(Map<String, dynamic> json) {
    return DashboardFavoriteCredentialModel(
      id: json['id'] as String,
      serviceName: json['serviceName'] as String,
      loginEmail: json['loginEmail'] as String?,
      username: json['username'] as String?,
      categoryId: json['categoryId'] as String?,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

class SecurityAlertModel {
  final String type;
  final String message;
  final int count;
  final String severity;

  SecurityAlertModel({
    required this.type,
    required this.message,
    required this.count,
    required this.severity,
  });

  factory SecurityAlertModel.fromJson(Map<String, dynamic> json) {
    return SecurityAlertModel(
      type: json['type'] as String,
      message: json['message'] as String,
      count: json['count'] as int,
      severity: json['severity'] as String,
    );
  }
}

class DashboardMainModel {
  final DashboardSummaryModel summary;
  final List<DashboardRecentCredentialModel> recentCredentials;
  final List<DashboardFavoriteCredentialModel> favoriteCredentials;
  final List<DashboardCategoryModel> topCategories;
  final List<SecurityAlertModel> securityAlerts;

  DashboardMainModel({
    required this.summary,
    required this.recentCredentials,
    required this.favoriteCredentials,
    required this.topCategories,
    required this.securityAlerts,
  });

  factory DashboardMainModel.fromJson(Map<String, dynamic> json) {
    return DashboardMainModel(
      summary: DashboardSummaryModel.fromJson(json['summary'] as Map<String, dynamic>),
      recentCredentials: (json['recentCredentials'] as List<dynamic>)
          .map((e) => DashboardRecentCredentialModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      favoriteCredentials: (json['favoriteCredentials'] as List<dynamic>)
          .map((e) => DashboardFavoriteCredentialModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topCategories: (json['topCategories'] as List<dynamic>)
          .map((e) => DashboardCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      securityAlerts: (json['securityAlerts'] as List<dynamic>)
          .map((e) => SecurityAlertModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}