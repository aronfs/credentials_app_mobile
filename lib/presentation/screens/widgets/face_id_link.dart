import 'package:flutter/material.dart';

/// Link de texto centrado para autenticación alternativa,
/// ej. "Usar reconocimiento facial".
class FaceIdLink extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color color;

  const FaceIdLink({
    super.key,
    this.label = 'Usar reconocimiento facial',
    this.onTap,
    this.color = const Color(0xFF5C8BFF),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}
