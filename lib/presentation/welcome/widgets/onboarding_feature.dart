import 'package:flutter/material.dart';

/// Representa una característica destacada en la pantalla de onboarding:
/// icono, colores, título y descripción corta.
class OnboardingFeature {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final String description;

  const OnboardingFeature({
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.description,
  });
}
