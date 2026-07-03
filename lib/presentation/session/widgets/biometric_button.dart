import 'package:flutter/material.dart';

/// Botón de autenticación biométrica: icono + texto, sin relleno.
/// Ancho completo, centrado, toque con efecto splash.
class BiometricButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;

  const BiometricButton({
    super.key,
    required this.label,
    this.onPressed,
    this.color = const Color(0xFF1A1A2E),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fingerprint, size: 22, color: color),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
