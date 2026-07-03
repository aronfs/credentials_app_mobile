import 'package:archive_secure/domain/entities/profile_user_entity.dart';

class ProfileRoleModel {
  final String id;
  final String name;

  const ProfileRoleModel({required this.id, required this.name});

  factory ProfileRoleModel.fromJson(Map<String, dynamic> json) {
    return ProfileRoleModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  ProfileRoleEntity toEntity() {
    return ProfileRoleEntity(id: id, name: name);
  }
}

class ProfileUserModel {
  final String id;
  final String name;
  final String email;
  final String roleId;
  final ProfileRoleModel? role;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProfileUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
    this.role,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      roleId: json['roleId'] as String,
      role: json['role'] != null
          ? ProfileRoleModel.fromJson(json['role'] as Map<String, dynamic>)
          : null,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  ProfileUserEntity toEntity() {
    return ProfileUserEntity(
      id: id,
      name: name,
      email: email,
      roleId: roleId,
      role: role?.toEntity(),
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
