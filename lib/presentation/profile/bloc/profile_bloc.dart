import 'package:archive_secure/core/security/token_storage.dart';
import 'package:archive_secure/domain/usecases/change_password_usecase.dart';
import 'package:archive_secure/domain/usecases/change_pin_usecase.dart';
import 'package:archive_secure/domain/usecases/get_profile_usecase.dart';
import 'package:archive_secure/domain/usecases/update_profile_name_usecase.dart';
import 'package:archive_secure/presentation/profile/bloc/profile_event.dart';
import 'package:archive_secure/presentation/profile/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileNameUseCase _updateProfileNameUseCase;
  final ChangePinUseCase _changePinUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final TokenStorage _tokenStorage;
  final void Function() _onSessionExpired;

  ProfileBloc({
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfileNameUseCase updateProfileNameUseCase,
    required ChangePinUseCase changePinUseCase,
    required ChangePasswordUseCase changePasswordUseCase,
    required TokenStorage tokenStorage,
    required void Function() onSessionExpired,
  })  : _getProfileUseCase = getProfileUseCase,
        _updateProfileNameUseCase = updateProfileNameUseCase,
        _changePinUseCase = changePinUseCase,
        _changePasswordUseCase = changePasswordUseCase,
        _tokenStorage = tokenStorage,
        _onSessionExpired = onSessionExpired,
        super(const ProfileInitial()) {
    on<ProfileRequested>(_onProfileRequested);
    on<ProfileNameUpdated>(_onProfileNameUpdated);
    on<ProfilePinChanged>(_onProfilePinChanged);
    on<ProfilePasswordChanged>(_onProfilePasswordChanged);
    on<ProfileLogoutRequested>(_onProfileLogoutRequested);
  }

  Future<void> _onProfileRequested(
    ProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    await _fetchProfile(emit);
  }

  Future<void> _onProfileNameUpdated(
    ProfileNameUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(ProfileUpdating(profile: currentState.profile));
    } else {
      emit(const ProfileUpdating());
    }
    try {
      final profile = await _updateProfileNameUseCase.call(event.name);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileFailure(_formatError(e)));
    }
  }

  Future<void> _onProfilePinChanged(
    ProfilePinChanged event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileUpdating());
    try {
      await _changePinUseCase.call(
        currentPin: event.currentPin,
        newPin: event.newPin,
      );
      await _fetchProfile(emit);
    } catch (e) {
      emit(ProfileFailure(_formatError(e)));
    }
  }

  Future<void> _onProfilePasswordChanged(
    ProfilePasswordChanged event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileUpdating());
    try {
      await _changePasswordUseCase.call(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      );
      await _tokenStorage.clearAll();
      _onSessionExpired();
    } catch (e) {
      emit(ProfileFailure(_formatError(e)));
    }
  }

  Future<void> _onProfileLogoutRequested(
    ProfileLogoutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    _onSessionExpired();
  }

  Future<void> _fetchProfile(Emitter<ProfileState> emit) async {
    try {
      final profile = await _getProfileUseCase.call();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileFailure(_formatError(e)));
    }
  }

  String _formatError(Object e) {
    final message = e.toString();
    if (message.contains('403')) return 'No tienes permiso para esta acción';
    if (message.contains('404')) return 'Perfil no encontrado';
    if (message.contains('400') || message.contains('422')) {
      return 'Datos inválidos. Verifique la información.';
    }
    if (message.contains('SocketException') ||
        message.contains('Connection refused')) {
      return 'No se pudo conectar con el servidor';
    }
    return 'Error al procesar la solicitud. Intente de nuevo.';
  }
}
