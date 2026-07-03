import 'package:flutter/material.dart';
import 'onboarding_feature.dart';

/// Tarjeta de característica: icono circular a la izquierda,
/// título en negrita y descripción corta a la derecha.
/// Fondo gris muy claro con borde sutil.
class OnboardingFeatureCard extends StatelessWidget {
  final OnboardingFeature feature;

  const OnboardingFeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEF0F4), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icono circular
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: feature.iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              feature.icon,
              size: 20,
              color: feature.iconColor,
            ),
          ),
          const SizedBox(width: 14),
          // Título + descripción
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  feature.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B6E80),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
