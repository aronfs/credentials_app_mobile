import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();

  // ===========================
  // Display
  // ===========================

  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 42,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.2,
    height: 1.15,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.0,
    height: 1.18,
  );

  // ===========================
  // Headlines
  // ===========================

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.8,
    height: 1.20,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.30,
  );

  // ===========================
  // Titles
  // ===========================

  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.30,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.40,
  );

  // ===========================
  // Body
  // ===========================

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.60,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.55,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.50,
  );

  // ===========================
  // Labels (JetBrains Mono)
  // ===========================

  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'JetBrains-Mono',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.20,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'JetBrains-Mono',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.20,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'JetBrains-Mono',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.30,
  );

  // ===========================
  // Buttons
  // ===========================

  static const TextStyle buttonLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  // ===========================
  // Captions
  // ===========================

  static const TextStyle caption = TextStyle(
    fontFamily: 'Inter',
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );

  // ===========================
  // Helpers
  // ===========================

  static TextTheme textTheme(Color color) {
    return TextTheme(
      displayLarge: displayLarge.copyWith(color: color),
      displayMedium: displayMedium.copyWith(color: color),

      headlineLarge: headlineLarge.copyWith(color: color),
      headlineMedium: headlineMedium.copyWith(color: color),
      headlineSmall: headlineSmall.copyWith(color: color),

      titleLarge: titleLarge.copyWith(color: color),
      titleMedium: titleMedium.copyWith(color: color),
      titleSmall: titleSmall.copyWith(color: color),

      bodyLarge: bodyLarge.copyWith(color: color),
      bodyMedium: bodyMedium.copyWith(color: color),
      bodySmall: bodySmall.copyWith(color: color),

      labelLarge: labelLarge.copyWith(color: color),
      labelMedium: labelMedium.copyWith(color: color),
      labelSmall: labelSmall.copyWith(color: color),
    );
  }
}