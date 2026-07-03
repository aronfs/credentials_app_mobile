import 'package:flutter/material.dart';

/// Footer de seguridad: icono de escudo + texto en mayúsculas pequeñas.
/// Usado en la parte inferior de pantallas de login/auth para
/// tranquilizar al usuario sobre el cifrado.
class SecurityFooter extends StatelessWidget {
  final String label;
  final Color color;

  const SecurityFooter({
    super.key,
    required this.label,
    this.color = const Color(0xFFB7BAC6),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shield_outlined, size: 13, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: color,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
