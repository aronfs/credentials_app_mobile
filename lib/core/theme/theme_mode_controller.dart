import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeModeStorageKey = 'theme_mode';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

Future<void> loadStoredThemeMode() async {
  try {
    final preferences = await SharedPreferences.getInstance().timeout(
      const Duration(seconds: 2),
    );
    themeNotifier.value = _themeModeFromStorage(
      preferences.getString(_themeModeStorageKey),
    );
  } catch (_) {
    themeNotifier.value = ThemeMode.light;
  }
}

Future<void> setAppThemeMode(ThemeMode mode) async {
  themeNotifier.value = mode;
  final preferences = await SharedPreferences.getInstance();
  await preferences.setString(_themeModeStorageKey, mode.name);
}

ThemeMode _themeModeFromStorage(String? value) {
  return ThemeMode.values.firstWhere(
    (mode) => mode.name == value,
    orElse: () => ThemeMode.light,
  );
}
