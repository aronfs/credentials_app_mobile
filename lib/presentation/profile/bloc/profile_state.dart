import 'package:archive_secure/domain/entities/profile_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileUpdating extends ProfileState {
  final ProfileEntity? profile;

  const ProfileUpdating({this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileActionSuccess extends ProfileState {
  final String message;
  final ProfileEntity? profile;

  const ProfileActionSuccess({required this.message, this.profile});

  @override
  List<Object?> get props => [message, profile];
}

class ProfileFailure extends ProfileState {
  final String error;

  const ProfileFailure(this.error);

  @override
  List<Object?> get props => [error];
}
