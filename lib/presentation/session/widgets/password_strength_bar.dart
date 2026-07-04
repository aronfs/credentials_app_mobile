import 'package:flutter/material.dart';

enum PasswordStrength { empty, weak, medium, strong }

extension PasswordStrengthExt on PasswordStrength {
  String get label {
    switch (this) {
      case PasswordStrength.empty:
        return '';
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.medium:
        return 'Medium';
      case PasswordStrength.strong:
        return 'Strong';
    }
  }

  Color get color {
    switch (this) {
      case PasswordStrength.empty:
        return const Color(0xFFE0E2EA);
      case PasswordStrength.weak:
        return const Color(0xFFE05757);
      case PasswordStrength.medium:
        return const Color(0xFFFFA726);
      case PasswordStrength.strong:
        return const Color(0xFF2E9E4F);
    }
  }

  double get fraction {
    switch (this) {
      case PasswordStrength.empty:
        return 0.0;
      case PasswordStrength.weak:
        return 0.33;
      case PasswordStrength.medium:
        return 0.66;
      case PasswordStrength.strong:
        return 1.0;
    }
  }

  /// Evalúa la fuerza de una contraseña dada.
  static PasswordStrength evaluate(String password) {
    if (password.isEmpty) return PasswordStrength.empty;
    int score = 0;
    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) score++;
    if (score <= 1) return PasswordStrength.weak;
    if (score == 2) return PasswordStrength.medium;
    return PasswordStrength.strong;
  }
}

/// Barra visual de fuerza de contraseña: línea animada de color +
/// label textual a la derecha (Débil / Medio / Fuerte).
class PasswordStrengthBar extends StatelessWidget {
  final PasswordStrength strength;
  final Map<PasswordStrength, String>? labels;

  const PasswordStrengthBar({
    super.key,
    required this.strength,
    this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final displayLabel = labels?[strength] ?? strength.label;
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Stack(
              children: [
                Container(height: 3, color: const Color(0xFFE0E2EA)),
                AnimatedFractionallySizedBox(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  widthFactor: strength.fraction,
                  child: Container(
                    height: 3,
                    color: strength.color,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (strength != PasswordStrength.empty) ...[
          const SizedBox(width: 10),
          Text(
            displayLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: strength.color,
            ),
          ),
        ],
      ],
    );
  }
}
