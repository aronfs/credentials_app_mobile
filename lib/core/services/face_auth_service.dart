import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

class FaceAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isFaceAvailable() async {
    try {
      final canCheckBiometrics = await _auth.canCheckBiometrics;
      final isSupported = await _auth.isDeviceSupported();
      final biometrics = await _getAvailableBiometrics();

      debugPrint('canCheckBiometrics: $canCheckBiometrics');
      debugPrint('isDeviceSupported: $isSupported');
      debugPrint('availableBiometrics: $biometrics');

      if (biometrics.contains(BiometricType.face)) return true;

      return canCheckBiometrics && isSupported;
    } on LocalAuthException catch (e) {
      debugPrint('Face availability error code: ${e.code}');
      debugPrint('Face availability error message: ${e.description}');
      return false;
    } catch (e) {
      debugPrint('Face availability unexpected error: $e');
      return false;
    }
  }

  Future<List<BiometricType>> _getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on LocalAuthException catch (e) {
      debugPrint('Available biometrics error code: ${e.code}');
      debugPrint('Available biometrics error message: ${e.description}');
      return const [];
    }
  }

  Future<bool> authenticateWithFace() async {
    try {
      final canAuthenticateWithSystemBiometrics = await isFaceAvailable();
      if (!canAuthenticateWithSystemBiometrics) return false;

      return await _auth.authenticate(
        localizedReason: 'Use face recognition to unlock',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
    } on LocalAuthException catch (e) {
      debugPrint('Face auth error code: ${e.code}');
      debugPrint('Face auth error message: ${e.description}');
      return false;
    } catch (e) {
      debugPrint('Face auth unexpected error: $e');
      return false;
    }
  }
}
