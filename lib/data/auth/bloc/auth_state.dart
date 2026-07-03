import 'package:archive_secure/data/auth/domain/entity/auth.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Auth auth;

  const AuthSuccess(this.auth);

  @override
  List<Object?> get props => [auth];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class PinVerified extends AuthState {}

class PinVerificationFailed extends AuthState {
  final String error;

  const PinVerificationFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class Unauthenticated extends AuthState {}

class SessionRefreshed extends AuthState {
  final Auth auth;

  const SessionRefreshed(this.auth);

  @override
  List<Object?> get props => [auth];
}
