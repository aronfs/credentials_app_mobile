import 'package:flutter/material.dart';

/// Indicador de progreso de PIN: N círculos que se rellenan
/// (blanco sólido) a medida que el usuario ingresa dígitos.
/// Los vacíos se muestran como anillos.
class PinDotsIndicator extends StatelessWidget {
  final int totalDigits;
  final int filledCount;
  final Color filledColor;
  final Color emptyColor;
  final double size;

  const PinDotsIndicator({
    super.key,
    this.totalDigits = 4,
    required this.filledCount,
    this.filledColor = Colors.white,
    this.emptyColor = Colors.transparent,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalDigits, (index) {
        final bool filled = index < filledCount;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: size * 0.5),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: filled ? filledColor : Colors.transparent,
              border: Border.all(
                color: const Color(0xFF6B7090),
                width: 1.5,
              ),
            ),
          ),
        );
      }),
    );
  }
}
