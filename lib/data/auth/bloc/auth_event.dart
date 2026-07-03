import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class VerifyPinSubmitted extends AuthEvent {
  final String pin;

  const VerifyPinSubmitted({required this.pin});

  @override
  List<Object?> get props => [pin];
}

class RegisterSubmitted extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String pin;

  const RegisterSubmitted({
    required this.name,
    required this.email,
    required this.password,
    required this.pin,
  });

  @override
  List<Object?> get props => [name, email, password, pin];
}

class LogoutSubmitted extends AuthEvent {
  final bool preserveBiometricLogin;

  const LogoutSubmitted({this.preserveBiometricLogin = true});

  @override
  List<Object?> get props => [preserveBiometricLogin];
}

class BiometricLoginRequested extends AuthEvent {
  final String reason;

  const BiometricLoginRequested({required this.reason});

  @override
  List<Object?> get props => [reason];
}

class RefreshSessionRequested extends AuthEvent {}
