import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

class AdvancedBiometricAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> canUseAdvancedBiometrics() async {
    try {
      final supported = await _auth.isDeviceSupported();
      final canCheck = await _auth.canCheckBiometrics;
      final biometrics = await _getAvailableBiometrics();

      debugPrint('advancedBiometrics.canCheckBiometrics: $canCheck');
      debugPrint('advancedBiometrics.isDeviceSupported: $supported');
      debugPrint('advancedBiometrics.availableBiometrics: $biometrics');

      return supported && canCheck;
    } on LocalAuthException catch (e) {
      debugPrint('Advanced biometric availability error code: ${e.code}');
      debugPrint(
        'Advanced biometric availability error message: ${e.description}',
      );
      return false;
    } catch (e) {
      debugPrint('Advanced biometric availability unexpected error: $e');
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

  Future<bool> authenticate() async {
    try {
      final available = await canUseAdvancedBiometrics();
      if (!available) return false;

      return await _auth.authenticate(
        localizedReason: 'Use advanced biometrics to continue',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
    } on LocalAuthException catch (e) {
      debugPrint('Advanced biometric auth error code: ${e.code}');
      debugPrint('Advanced biometric auth error message: ${e.description}');
      return false;
    } catch (e) {
      debugPrint('Advanced biometric auth unexpected error: $e');
      return false;
    }
  }
}
