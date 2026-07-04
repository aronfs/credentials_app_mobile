import 'package:archive_secure/ui.theme/size_app.dart';
import 'package:archive_secure/ui.theme/styles/color_scheme_app.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const double _radius = 12;

  static ThemeData light() => _build(AppColorScheme.light);

  static ThemeData dark() => _build(AppColorScheme.dark);

  static ThemeData _build(ColorScheme scheme) {
    final surface = scheme.surface;
    final fieldFill = scheme.surfaceContainerHighest.withValues(alpha: .42);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: scheme.brightness,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: surface,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w800,
          fontFamily: 'Inter',
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: fieldFill,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: scheme.secondary,
          foregroundColor: scheme.onSecondary,
          disabledBackgroundColor: scheme.outlineVariant,
          disabledForegroundColor: scheme.onSurface.withValues(alpha: .45),
          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: scheme.secondary,
          foregroundColor: scheme.onSecondary,
          elevation: 0,
          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: scheme.outline),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: scheme.secondary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.secondary,
        foregroundColor: scheme.onSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: fieldFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 16,
        ),
        labelStyle: TextStyle(
          color: scheme.onSurface,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
        hintStyle: TextStyle(
          color: scheme.onSurface.withValues(alpha: .42),
          fontSize: 14,
        ),
        prefixIconColor: scheme.onSurface.withValues(alpha: .65),
        suffixIconColor: scheme.onSurface.withValues(alpha: .65),
        border: _inputBorder(scheme.outline),
        enabledBorder: _inputBorder(scheme.outline),
        focusedBorder: _inputBorder(scheme.secondary, width: 1.6),
        errorBorder: _inputBorder(scheme.error),
        focusedErrorBorder: _inputBorder(scheme.error, width: 1.6),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.onSecondary
              : scheme.outline,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.secondary
              : scheme.outlineVariant,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: fieldFill,
        selectedItemColor: scheme.secondary,
        unselectedItemColor: scheme.onSurface.withValues(alpha: .58),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static ThemeData get themeWelcome => ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.light,
    scaffoldBackgroundColor: AppColorScheme.light.surface,
    appBarTheme: AppBarTheme(backgroundColor: AppColorScheme.light.onPrimary),
  );

  static OutlineInputBorder get borderText => OutlineInputBorder(
    borderRadius: BorderRadius.circular(sizeRadiusTextField),
    borderSide: BorderSide(color: AppColorScheme.light.outline, width: 1.2),
  );

  static OutlineInputBorder get focusedBorderText => OutlineInputBorder(
    borderRadius: BorderRadius.circular(sizeRadiusTextField),
    borderSide: BorderSide(color: AppColorScheme.light.primary, width: 1.5),
  );

  static ThemeData get themeForms => ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.light,

    scaffoldBackgroundColor: AppColorScheme.light.onPrimary,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColorScheme.light.onPrimary,
      elevation: 0,
      foregroundColor: AppColorScheme.light.onSurface,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorScheme.light.secondary,
        foregroundColor: AppColorScheme.light.onSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sizeRadiusButton),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorScheme.light.onPrimary,

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

      hintStyle: TextStyle(
        color: AppColorScheme.light.onSurface.withValues(alpha: 0.45),
        fontSize: 16,
      ),

      labelStyle: TextStyle(
        color: AppColorScheme.light.onSurface,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
      ),

      prefixIconColor: AppColorScheme.light.onSurface.withValues(alpha: 0.65),
      suffixIconColor: AppColorScheme.light.onSurface.withValues(alpha: 0.65),

      border: borderText,
      enabledBorder: borderText,
      focusedBorder: focusedBorderText,
      disabledBorder: borderText,
      errorBorder: borderText,
      focusedErrorBorder: focusedBorderText,
    ),
  );

  static ThemeData lightTheme = light();

  static ThemeData darkTheme = dark();
}
