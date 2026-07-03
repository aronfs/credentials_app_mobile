import 'package:equatable/equatable.dart';

class ProfileRoleEntity extends Equatable {
  final String id;
  final String name;

  const ProfileRoleEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class ProfileUserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String roleId;
  final ProfileRoleEntity? role;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProfileUserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
    this.role,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        roleId,
        role,
        isActive,
        createdAt,
        updatedAt,
      ];
}
