import 'package:shared_preferences/shared_preferences.dart';

class FaceAuthPreferencesService {
  static const _faceAuthEnabledKey = 'face_auth_enabled';
  static const _firstFaceSetupDoneKey = 'first_face_setup_done';

  Future<bool> isFaceAuthEnabled() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_faceAuthEnabledKey) ?? false;
  }

  Future<void> setFaceAuthEnabled(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_faceAuthEnabledKey, value);
  }

  Future<bool> isFirstFaceSetupDone() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_firstFaceSetupDoneKey) ?? false;
  }

  Future<void> setFirstFaceSetupDone(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_firstFaceSetupDoneKey, value);
  }
}
