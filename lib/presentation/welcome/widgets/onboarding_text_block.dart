import 'package:flutter/material.dart';

/// Bloque de texto central del onboarding: título grande en negrita
/// y párrafo descriptivo con color gris, ambos centrados.
class OnboardingTextBlock extends StatelessWidget {
  final String title;
  final String description;

  const OnboardingTextBlock({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14.5,
            color: Color(0xFF6B6E80),
            height: 1.55,
          ),
        ),
      ],
    );
  }
}
