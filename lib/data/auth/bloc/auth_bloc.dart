import 'package:archive_secure/core/security/biometric_service.dart';
import 'package:archive_secure/core/security/token_storage.dart';
import 'package:archive_secure/data/auth/bloc/auth_event.dart';
import 'package:archive_secure/data/auth/bloc/auth_state.dart';
import 'package:archive_secure/data/auth/domain/repository/auth_repository.dart';
import 'package:archive_secure/data/auth/domain/usecase/register.dart';
import 'package:archive_secure/data/auth/domain/usecase/sign_in.dart';
import 'package:archive_secure/data/auth/domain/usecase/verify_pin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this._signIn,
    required this._verifyPin,
    required this._register,
    required this._tokenStorage,
    required this._authRepository,
    required this._biometricService,
  }) : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<VerifyPinSubmitted>(_onVerifyPinSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<LogoutSubmitted>(_onLogoutSubmitted);
    on<BiometricLoginRequested>(_onBiometricLoginRequested);
    on<RefreshSessionRequested>(_onRefreshSessionRequested);
  }

  final SignIn _signIn;
  final VerifyPin _verifyPin;
  final Register _register;
  final TokenStorage _tokenStorage;
  final AuthRepository _authRepository;
  final BiometricService _biometricService;

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final auth = await _signIn.call(event.email, event.password);
      emit(AuthSuccess(auth));
    } catch (e) {
      emit(AuthFailure(_formatLoginError(e)));
    }
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final auth = await _register.call(
        event.name,
        event.email,
        event.password,
        event.pin,
      );
      emit(AuthSuccess(auth));
    } catch (e) {
      emit(AuthFailure(_formatRegisterError(e)));
    }
  }

  Future<void> _onVerifyPinSubmitted(
    VerifyPinSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final isValid = await _verifyPin.call(event.pin);
      if (isValid) {
        emit(PinVerified());
      } else {
        emit(const PinVerificationFailed('PIN inválido'));
      }
    } catch (e) {
      emit(PinVerificationFailed(_formatPinError(e)));
    }
  }

  Future<void> _onLogoutSubmitted(
    LogoutSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    await _tokenStorage.clearForLogout(
      preserveBiometricLogin: event.preserveBiometricLogin,
    );
    emit(Unauthenticated());
  }

  Future<void> _onBiometricLoginRequested(
    BiometricLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final authenticated = await _biometricService.authenticate(
        reason: event.reason,
      );
      if (!authenticated) {
        emit(const AuthFailure('Autenticación cancelada.'));
        return;
      }
      final auth = await _authRepository.refreshSession();
      emit(SessionRefreshed(auth));
    } on BiometricException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No refresh token available')) {
        emit(
          const AuthFailure(
            'Sesión expirada. Inicia sesión con tu correo y contraseña.',
          ),
        );
      } else {
        emit(AuthFailure(_formatLoginError(e)));
      }
    }
  }

  Future<void> _onRefreshSessionRequested(
    RefreshSessionRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final auth = await _authRepository.refreshSession();
      emit(SessionRefreshed(auth));
    } catch (e) {
      emit(AuthFailure(_formatLoginError(e)));
    }
  }

  String _formatLoginError(Object e) {
    final message = e.toString();
    if (message.contains('401')) return 'Credenciales incorrectas';
    if (message.contains('SocketException') ||
        message.contains('Connection refused')) {
      return 'No se pudo conectar con el servidor';
    }
    if (message.contains('No refresh token available')) {
      return 'Sesión expirada. Inicia sesión con tu correo y contraseña.';
    }
    return 'Error al iniciar sesión. Intente de nuevo.';
  }

  String _formatRegisterError(Object e) {
    final message = e.toString();
    if (message.contains('400') || message.contains('422')) {
      return 'Datos inválidos. Verifique la información.';
    }
    if (message.contains('SocketException') ||
        message.contains('Connection refused')) {
      return 'No se pudo conectar con el servidor';
    }
    return 'Error al registrar. Intente de nuevo.';
  }

  String _formatPinError(Object e) {
    final message = e.toString();
    if (message.contains('SocketException') ||
        message.contains('Connection refused')) {
      return 'No se pudo conectar con el servidor';
    }
    return 'Error al verificar el PIN. Intente de nuevo.';
  }
}
