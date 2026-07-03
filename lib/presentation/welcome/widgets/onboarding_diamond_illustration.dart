import 'package:flutter/material.dart';

/// Ilustración de onboarding: rombo (cuadrado rotado 45°) con borde
/// gris claro, fondo gris muy suave e icono centrado en círculo azul
/// claro. Configurable en icono, colores y tamaño.
class OnboardingDiamondIllustration extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final Color diamondBorderColor;
  final Color diamondFillColor;
  final double size;

  const OnboardingDiamondIllustration({
    super.key,
    required this.icon,
    this.iconColor = const Color(0xFF2962FF),
    this.iconBackgroundColor = const Color(0xFFDCE6FB),
    this.diamondBorderColor = const Color(0xFFDDDFE8),
    this.diamondFillColor = const Color(0xFFF2F3F7),
    this.size = 180,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Rombo exterior (borde)
          Transform.rotate(
            angle: 0.785398, // 45 grados en radianes
            child: Container(
              width: size * 0.72,
              height: size * 0.72,
              decoration: BoxDecoration(
                color: diamondFillColor,
                borderRadius: BorderRadius.circular(size * 0.1),
                border: Border.all(color: diamondBorderColor, width: 1.5),
              ),
            ),
          ),
          // Icono centrado en círculo
          Container(
            width: size * 0.3,
            height: size * 0.3,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: size * 0.16, color: iconColor),
          ),
        ],
      ),
    );
  }
}
