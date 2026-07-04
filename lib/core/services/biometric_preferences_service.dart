import 'package:shared_preferences/shared_preferences.dart';

class BiometricPreferencesService {
  static const _biometricEnabledKey = 'biometric_enabled';
  static const _firstBiometricSetupDoneKey = 'first_biometric_setup_done';

  Future<bool> isBiometricEnabled() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_biometricEnabledKey) ?? false;
  }

  Future<void> setBiometricEnabled(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_biometricEnabledKey, value);
  }

  Future<bool> isFirstBiometricSetupDone() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_firstBiometricSetupDoneKey) ?? false;
  }

  Future<void> setFirstBiometricSetupDone(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_firstBiometricSetupDoneKey, value);
  }
}
