import 'package:flutter/material.dart';

/// Botón/badge de icono decorativo que se posiciona en la esquina
/// superior derecha de una pantalla. Ej: el rayo amarillo del
/// onboarding de "Acceso rápido".
class CornerIconBadge extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const CornerIconBadge({
    super.key,
    required this.icon,
    this.iconColor = const Color(0xFFFFC107),
    this.backgroundColor = const Color(0xFFFFF8E1),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 20, color: iconColor),
        ),
      ),
    );
  }
}
