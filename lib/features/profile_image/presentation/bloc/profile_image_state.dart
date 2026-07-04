import 'package:archive_secure/features/profile_image/domain/entities/profile_image_entity.dart';
import 'package:equatable/equatable.dart';
import 'dart:typed_data';

abstract class ProfileImageState extends Equatable {
  const ProfileImageState();

  @override
  List<Object?> get props => [];
}

class ProfileImageInitial extends ProfileImageState {
  const ProfileImageInitial();
}

class ProfileImageLoading extends ProfileImageState {
  const ProfileImageLoading();
}

class ProfileImageLoaded extends ProfileImageState {
  final ProfileImageEntity? metadata;
  final Uint8List? bytes;

  const ProfileImageLoaded({this.metadata, this.bytes});

  @override
  List<Object?> get props => [metadata, bytes];
}

class ProfileImageEmpty extends ProfileImageState {
  const ProfileImageEmpty();
}

class ProfileImageUploading extends ProfileImageState {
  const ProfileImageUploading();
}

class ProfileImageUploadSuccess extends ProfileImageState {
  const ProfileImageUploadSuccess();
}

class ProfileImageDeleting extends ProfileImageState {
  const ProfileImageDeleting();
}

class ProfileImageDeleteSuccess extends ProfileImageState {
  const ProfileImageDeleteSuccess();
}

class ProfileImageFailure extends ProfileImageState {
  final String message;

  const ProfileImageFailure(this.message);

  @override
  List<Object?> get props => [message];
}
