import 'package:archive_secure/data/profile/data/profile_models.dart';
import 'package:archive_secure/data/profile/data/profile_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileState {
  final ProfileStatus status;
  final ProfileMeModel? data;
  final String? error;
  final String? successMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.data,
    this.error,
    this.successMessage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileMeModel? data,
    String? error,
    String? successMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
      successMessage: successMessage,
    );
  }
}

enum ProfileStatus { initial, loading, success, error, updated }

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService _service;

  ProfileCubit(this._service) : super(const ProfileState());

  Future<void> load() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final data = await _service.getMe();
      emit(state.copyWith(status: ProfileStatus.success, data: data));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        error: 'Error al cargar el perfil',
      ));
    }
  }

  Future<void> updateName(String name) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      await _service.updateProfile(name);
      await load();
      emit(state.copyWith(
        status: ProfileStatus.updated,
        successMessage: 'Perfil actualizado correctamente',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        error: 'Error al actualizar el perfil',
      ));
    }
  }

  Future<void> changePin(String currentPin, String newPin) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      await _service.changePin(currentPin, newPin);
      emit(state.copyWith(
        status: ProfileStatus.updated,
        successMessage: 'PIN actualizado correctamente',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        error: 'Error al cambiar el PIN',
      ));
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      await _service.changePassword(currentPassword, newPassword);
      emit(state.copyWith(
        status: ProfileStatus.updated,
        successMessage: 'Contraseña actualizada correctamente',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        error: 'Error al cambiar la contraseña',
      ));
    }
  }
}