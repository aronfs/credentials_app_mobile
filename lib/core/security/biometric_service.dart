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
        message: 'Biometric authentication failed.',
      );
    }
  }

  BiometricException _mapError(LocalAuthException e) {
    switch (e.code) {
      case LocalAuthExceptionCode.noBiometricHardware:
        return const BiometricException(
          type: BiometricErrorType.notAvailable,
          message: 'Biometric authentication not available on this device.',
        );
      case LocalAuthExceptionCode.noBiometricsEnrolled:
      case LocalAuthExceptionCode.noCredentialsSet:
        return const BiometricException(
          type: BiometricErrorType.notEnrolled,
          message: 'No biometrics enrolled on this device.',
        );
      case LocalAuthExceptionCode.temporaryLockout:
        return const BiometricException(
          type: BiometricErrorType.lockedOut,
          message: 'Too many failed attempts. Try again later.',
        );
      case LocalAuthExceptionCode.biometricLockout:
        return const BiometricException(
          type: BiometricErrorType.permanentlyLockedOut,
          message: 'Biometrics is blocked. Unlock it from device settings.',
        );
      case LocalAuthExceptionCode.userCanceled:
      case LocalAuthExceptionCode.systemCanceled:
      case LocalAuthExceptionCode.userRequestedFallback:
        return const BiometricException(
          type: BiometricErrorType.userCancel,
          message: 'Authentication cancelled.',
        );
      default:
        return const BiometricException(
          type: BiometricErrorType.unknown,
          message: 'Biometric authentication failed.',
        );
    }
  }
}
