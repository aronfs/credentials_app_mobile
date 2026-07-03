import 'package:flutter/material.dart';

class AppColorScheme {
  AppColorScheme._();

  // ===========================
  // Brand Colors
  // ===========================

  static const Color primary = Color(0xFF0F172A);
  static const Color secondary = Color(0xFF3B82F6);
  static const Color tertiary = Color(0xFF1E293B);

  static const Color neutral = Color(0xFFF8FAFC);

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF0EA5E9);

  // ===========================
  // Light Theme
  // ===========================

  static final ColorScheme light = ColorScheme(
    brightness: Brightness.light,

    primary: primary,
    onPrimary: Colors.white,

    secondary: secondary,
    onSecondary: Colors.white,

    tertiary: tertiary,
    onTertiary: Colors.white,

    error: error,
    onError: Colors.white,

    surface: neutral,
    onSurface: Color(0xFF0F172A),

    surfaceContainerHighest: Color(0xFFE2E8F0),

    outline: Color(0xFFCBD5E1),
    outlineVariant: Color(0xFFE2E8F0),

    shadow: Colors.black26,
    scrim: Colors.black54,

    inverseSurface: Color(0xFF1E293B),
    onInverseSurface: Colors.white,
    inversePrimary: secondary,
  );

  // ===========================
  // Dark Theme
  // ===========================

  static final ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,

    primary: secondary,
    onPrimary: Colors.white,

    secondary: Color(0xFF60A5FA),
    onSecondary: Colors.white,

    tertiary: Color(0xFF334155),
    onTertiary: Colors.white,

    error: Color(0xFFF87171),
    onError: Colors.black,

    surface: Color(0xFF0B1120),
    onSurface: Color(0xFFF8FAFC),

    surfaceContainerHighest: Color(0xFF1E293B),

    outline: Color(0xFF475569),
    outlineVariant: Color(0xFF334155),

    shadow: Colors.black,
    scrim: Colors.black87,

    inverseSurface: Color(0xFFF8FAFC),
    onInverseSurface: Color(0xFF0F172A),
    inversePrimary: primary,
  );
}