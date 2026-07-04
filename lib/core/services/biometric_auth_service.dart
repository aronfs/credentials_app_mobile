import 'package:local_auth/local_auth.dart';

enum BiometricAuthFailure {
  notAvailable,
  notEnrolled,
  lockedOut,
  canceled,
  uiUnavailable,
  unknown,
}

class BiometricAuthException implements Exception {
  const BiometricAuthException(this.failure);

  final BiometricAuthFailure failure;
}

class BiometricAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isDeviceSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on LocalAuthException catch (e) {
      throw _mapException(e);
    } catch (_) {
      throw const BiometricAuthException(BiometricAuthFailure.unknown);
    }
  }

  Future<bool> hasAvailableBiometrics() async {
    try {
      final biometrics = await getAvailableBiometrics();
      return biometrics.isNotEmpty;
    } on BiometricAuthException {
      rethrow;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate({String? localizedReason}) async {
    try {
      final result = await _auth.authenticate(
        localizedReason: localizedReason ?? 'Authenticate to unlock',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
      return result;
    } on LocalAuthException catch (e) {
      throw _mapException(e);
    } catch (_) {
      throw const BiometricAuthException(BiometricAuthFailure.unknown);
    }
  }

  BiometricAuthException _mapException(LocalAuthException e) {
    switch (e.code) {
      case LocalAuthExceptionCode.noBiometricHardware:
      case LocalAuthExceptionCode.biometricHardwareTemporarilyUnavailable:
        return const BiometricAuthException(BiometricAuthFailure.notAvailable);
      case LocalAuthExceptionCode.noBiometricsEnrolled:
      case LocalAuthExceptionCode.noCredentialsSet:
        return const BiometricAuthException(BiometricAuthFailure.notEnrolled);
      case LocalAuthExceptionCode.temporaryLockout:
      case LocalAuthExceptionCode.biometricLockout:
        return const BiometricAuthException(BiometricAuthFailure.lockedOut);
      case LocalAuthExceptionCode.userCanceled:
      case LocalAuthExceptionCode.systemCanceled:
      case LocalAuthExceptionCode.userRequestedFallback:
      case LocalAuthExceptionCode.timeout:
        return const BiometricAuthException(BiometricAuthFailure.canceled);
      case LocalAuthExceptionCode.uiUnavailable:
      case LocalAuthExceptionCode.authInProgress:
        return const BiometricAuthException(BiometricAuthFailure.uiUnavailable);
      case LocalAuthExceptionCode.deviceError:
      case LocalAuthExceptionCode.unknownError:
        return const BiometricAuthException(BiometricAuthFailure.unknown);
    }
  }
}
