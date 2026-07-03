import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String id;
  final String name;
  final String email;
  final String roleId;
  final String accessToken;
  final String refreshToken;

  const Auth({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [id, name, email, roleId, accessToken, refreshToken];
}