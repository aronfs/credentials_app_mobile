import 'package:local_auth/local_auth.dart';

enum BiometricErrorType {
  notAvailable,
  notEnrolled,
  lockedOut,
  permanentlyLockedOut,
  userCancel,
  unknown,
}

class BiometricException implements Exception {
  final BiometricErrorType type;
  final String message;

  const BiometricException({required this.type, required this.message});

  @override
  String toString() => message;
}

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isAvailable() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<bool> hasEnrolledBiometrics() async {
    try {
      final available = await _auth.isDeviceSupported();
      if (!available) return false;
      final biometrics = await _auth.getAvailableBiometrics();
      return biometrics.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> canUseBiometrics() async {
    try {
      final available = await _auth.isDeviceSupported();
      if (!available) return false;
      final biometrics = await _auth.getAvailableBiometrics();
      return biometrics.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate({String reason = ''}) async {
    try {
      final result = await _auth.authenticate(
        localizedReason: reason,
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
      return result;
    } on LocalAuthException catch (e) {
      throw _mapError(e);
    } catch (e) {
      throw const BiometricException(
        type: BiometricErrorType.unknown,
        message: 'No se pudo completar la autenticación biométrica.',
      );
    }
  }

  BiometricException _mapError(LocalAuthException e) {
    switch (e.code) {
      case LocalAuthExceptionCode.noBiometricHardware:
        return const BiometricException(
          type: BiometricErrorType.notAvailable,
          message: 'Este dispositivo no soporta autenticación biométrica.',
        );
      case LocalAuthExceptionCode.noBiometricsEnrolled:
      case LocalAuthExceptionCode.noCredentialsSet:
        return const BiometricException(
          type: BiometricErrorType.notEnrolled,
          message:
              'No tienes huellas o Face ID configurados en el dispositivo.',
        );
      case LocalAuthExceptionCode.temporaryLockout:
        return const BiometricException(
          type: BiometricErrorType.lockedOut,
          message:
              'Demasiados intentos fallidos. Intenta nuevamente más tarde.',
        );
      case LocalAuthExceptionCode.biometricLockout:
        return const BiometricException(
          type: BiometricErrorType.permanentlyLockedOut,
          message:
              'La biometría está bloqueada. Desbloquéala desde los ajustes del dispositivo.',
        );
      case LocalAuthExceptionCode.userCanceled:
      case LocalAuthExceptionCode.systemCanceled:
      case LocalAuthExceptionCode.userRequestedFallback:
        return const BiometricException(
          type: BiometricErrorType.userCancel,
          message: 'Autenticación cancelada.',
        );
      default:
        return const BiometricException(
          type: BiometricErrorType.unknown,
          message: 'No se pudo completar la autenticación biométrica.',
        );
    }
  }
}
