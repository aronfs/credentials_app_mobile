class AppLockService {
  AppLockService._();

  static final AppLockService instance = AppLockService._();

  bool _isUnlocked = false;
  bool _isBiometricUnlockInProgress = false;

  bool get isUnlocked => _isUnlocked;
  bool get isBiometricUnlockInProgress => _isBiometricUnlockInProgress;

  bool get shouldBypassLockScreen =>
      _isUnlocked || _isBiometricUnlockInProgress;

  void beginBiometricUnlock() {
    _isBiometricUnlockInProgress = true;
  }

  void finishBiometricUnlock({required bool success}) {
    _isBiometricUnlockInProgress = false;
    if (success) {
      _isUnlocked = true;
    }
  }

  Future<void> setUnlocked(bool value) async {
    _isUnlocked = value;
    if (value) {
      _isBiometricUnlockInProgress = false;
    }
  }

  void setLocked() {
    _isUnlocked = false;
  }
}
