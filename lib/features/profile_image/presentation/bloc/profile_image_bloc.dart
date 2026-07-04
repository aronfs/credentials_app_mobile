import 'package:archive_secure/core/services/app_lock_service.dart';
import 'package:archive_secure/features/profile_image/domain/usecases/delete_profile_image.dart';
import 'package:archive_secure/features/profile_image/domain/usecases/get_profile_image.dart';
import 'package:archive_secure/features/profile_image/domain/usecases/get_profile_image_file.dart';
import 'package:archive_secure/features/profile_image/domain/usecases/upload_profile_image.dart';
import 'package:archive_secure/features/profile_image/presentation/bloc/profile_image_event.dart';
import 'package:archive_secure/features/profile_image/presentation/bloc/profile_image_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageState> {
  final GetProfileImage _getProfileImage;
  final GetProfileImageFile _getProfileImageFile;
  final UploadProfileImage _uploadProfileImage;
  final DeleteProfileImage _deleteProfileImage;
  final ImagePicker _imagePicker;
  final AppLockService _appLockService;

  ProfileImageBloc({
    required GetProfileImage getProfileImage,
    required GetProfileImageFile getProfileImageFile,
    required UploadProfileImage uploadProfileImage,
    required DeleteProfileImage deleteProfileImage,
    ImagePicker? imagePicker,
    AppLockService? appLockService,
  })  : _getProfileImage = getProfileImage,
        _getProfileImageFile = getProfileImageFile,
        _uploadProfileImage = uploadProfileImage,
        _deleteProfileImage = deleteProfileImage,
        _imagePicker = imagePicker ?? ImagePicker(),
        _appLockService = appLockService ?? AppLockService.instance,
        super(const ProfileImageInitial()) {
    on<ProfileImageStarted>(_onStarted);
    on<ProfileImageMetadataRequested>(_onMetadataRequested);
    on<ProfileImageFileRequested>(_onFileRequested);
    on<ProfileImageUploadRequested>(_onUploadRequested);
    on<ProfileImageDeleteRequested>(_onDeleteRequested);
    on<ProfileImagePickFromGalleryRequested>(_onPickFromGallery);
    on<ProfileImagePickFromCameraRequested>(_onPickFromCamera);
  }

  Future<void> _onStarted(
    ProfileImageStarted event,
    Emitter<ProfileImageState> emit,
  ) async {
    emit(const ProfileImageLoading());
    try {
      final metadata = await _getProfileImage.call();
      if (metadata == null) {
        emit(const ProfileImageEmpty());
        return;
      }
      final bytes = await _getProfileImageFile.call();
      emit(ProfileImageLoaded(metadata: metadata, bytes: bytes));
    } on Exception catch (_) {
      emit(const ProfileImageEmpty());
    }
  }

  Future<void> _onMetadataRequested(
    ProfileImageMetadataRequested event,
    Emitter<ProfileImageState> emit,
  ) async {
    emit(const ProfileImageLoading());
    try {
      final metadata = await _getProfileImage.call();
      if (metadata == null) {
        emit(const ProfileImageEmpty());
        return;
      }
      emit(ProfileImageLoaded(metadata: metadata));
    } catch (e) {
      emit(ProfileImageFailure(e.toString()));
    }
  }

  Future<void> _onFileRequested(
    ProfileImageFileRequested event,
    Emitter<ProfileImageState> emit,
  ) async {
    final current = state;
    if (current is ProfileImageLoaded) {
      try {
        final bytes = await _getProfileImageFile.call();
        emit(ProfileImageLoaded(metadata: current.metadata, bytes: bytes));
      } catch (_) {
        emit(ProfileImageLoaded(metadata: current.metadata));
      }
    }
  }

  Future<void> _onUploadRequested(
    ProfileImageUploadRequested event,
    Emitter<ProfileImageState> emit,
  ) async {
    emit(const ProfileImageUploading());
    try {
      await _uploadProfileImage.call(event.filePath);
      emit(const ProfileImageUploadSuccess());
      final metadata = await _getProfileImage.call();
      if (metadata == null) {
        emit(const ProfileImageEmpty());
        return;
      }
      final bytes = await _getProfileImageFile.call();
      emit(ProfileImageLoaded(metadata: metadata, bytes: bytes));
    } catch (e) {
      emit(ProfileImageFailure(e.toString()));
    }
  }

  Future<void> _onDeleteRequested(
    ProfileImageDeleteRequested event,
    Emitter<ProfileImageState> emit,
  ) async {
    emit(const ProfileImageDeleting());
    try {
      await _deleteProfileImage.call();
      emit(const ProfileImageDeleteSuccess());
      emit(const ProfileImageEmpty());
    } catch (e) {
      emit(ProfileImageFailure(e.toString()));
    }
  }

  Future<void> _onPickFromGallery(
    ProfileImagePickFromGalleryRequested event,
    Emitter<ProfileImageState> emit,
  ) async {
    _appLockService.beginImagePicker();
    try {
      final picked = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (picked == null) return;
      add(ProfileImageUploadRequested(picked.path));
    } catch (_) {
      emit(const ProfileImageFailure('No se pudo acceder a la galería.'));
    } finally {
      _appLockService.finishImagePicker();
    }
  }

  Future<void> _onPickFromCamera(
    ProfileImagePickFromCameraRequested event,
    Emitter<ProfileImageState> emit,
  ) async {
    _appLockService.beginImagePicker();
    try {
      final picked = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (picked == null) return;
      add(ProfileImageUploadRequested(picked.path));
    } catch (_) {
      emit(const ProfileImageFailure('No se pudo acceder a la cámara.'));
    } finally {
      _appLockService.finishImagePicker();
    }
  }
}
