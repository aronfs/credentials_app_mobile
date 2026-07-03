import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileRequested extends ProfileEvent {
  const ProfileRequested();
}

class ProfileNameUpdated extends ProfileEvent {
  final String name;

  const ProfileNameUpdated({required this.name});

  @override
  List<Object?> get props => [name];
}

class ProfilePinChanged extends ProfileEvent {
  final String currentPin;
  final String newPin;

  const ProfilePinChanged({
    required this.currentPin,
    required this.newPin,
  });

  @override
  List<Object?> get props => [currentPin, newPin];
}

class ProfilePasswordChanged extends ProfileEvent {
  final String currentPassword;
  final String newPassword;

  const ProfilePasswordChanged({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword];
}

class ProfileLogoutRequested extends ProfileEvent {
  const ProfileLogoutRequested();
}
