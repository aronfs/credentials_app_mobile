class ProfileMeModel {
  final ProfileUserModel user;
  final ProfileStatsModel stats;

  ProfileMeModel({required this.user, required this.stats});

  factory ProfileMeModel.fromJson(Map<String, dynamic> json) {
    return ProfileMeModel(
      user: ProfileUserModel.fromJson(json['user'] as Map<String, dynamic>),
      stats: ProfileStatsModel.fromJson(json['stats'] as Map<String, dynamic>),
    );
  }
}

class ProfileUserModel {
  final String id;
  final String name;
  final String email;
  final String roleId;
  final ProfileRoleModel role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfileUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      roleId: json['roleId'] as String,
      role: ProfileRoleModel.fromJson(json['role'] as Map<String, dynamic>),
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

class ProfileRoleModel {
  final String id;
  final String name;

  ProfileRoleModel({required this.id, required this.name});

  factory ProfileRoleModel.fromJson(Map<String, dynamic> json) {
    return ProfileRoleModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}

class ProfileStatsModel {
  final int totalCredentials;
  final int totalCategories;
  final int totalFavorites;

  ProfileStatsModel({
    required this.totalCredentials,
    required this.totalCategories,
    required this.totalFavorites,
  });

  factory ProfileStatsModel.fromJson(Map<String, dynamic> json) {
    return ProfileStatsModel(
      totalCredentials: json['totalCredentials'] as int,
      totalCategories: json['totalCategories'] as int,
      totalFavorites: json['totalFavorites'] as int,
    );
  }
}