import 'package:equatable/equatable.dart';

abstract class ProfileImageEvent extends Equatable {
  const ProfileImageEvent();

  @override
  List<Object?> get props => [];
}

class ProfileImageStarted extends ProfileImageEvent {
  const ProfileImageStarted();
}

class ProfileImageMetadataRequested extends ProfileImageEvent {
  const ProfileImageMetadataRequested();
}

class ProfileImageFileRequested extends ProfileImageEvent {
  const ProfileImageFileRequested();
}

class ProfileImageUploadRequested extends ProfileImageEvent {
  final String filePath;

  const ProfileImageUploadRequested(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class ProfileImageDeleteRequested extends ProfileImageEvent {
  const ProfileImageDeleteRequested();
}

class ProfileImagePickFromGalleryRequested extends ProfileImageEvent {
  const ProfileImagePickFromGalleryRequested();
}

class ProfileImagePickFromCameraRequested extends ProfileImageEvent {
  const ProfileImagePickFromCameraRequested();
}
