import 'package:flutter/material.dart';

/// Dibuja un icono de candado con el aro (shackle) y el cuerpo en
/// colores independientes, para replicar fielmente diseños donde el
/// candado tiene dos tonos (ej. aro azul, cuerpo oscuro).
class PadlockPainter extends CustomPainter {
  final Color bodyColor;
  final Color shackleColor;

  const PadlockPainter({
    required this.bodyColor,
    required this.shackleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Aro (shackle): arco grueso en la parte superior
    final shacklePaint = Paint()
      ..color = shackleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.14
      ..strokeCap = StrokeCap.round;

    final shackleRect = Rect.fromLTWH(
      w * 0.28,
      h * 0.02,
      w * 0.44,
      h * 0.52,
    );
    canvas.drawArc(shackleRect, 3.4, 2.6, false, shacklePaint);

    // Cuerpo del candado: rectángulo redondeado
    final bodyPaint = Paint()..color = bodyColor;
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.14, h * 0.42, w * 0.72, h * 0.5),
      Radius.circular(w * 0.12),
    );
    canvas.drawRRect(bodyRect, bodyPaint);

    // Ojo de la cerradura: círculo + trazo
    final keyholePaint = Paint()..color = shackleColor;
    final Offset keyholeCenter = Offset(w * 0.5, h * 0.62);
    canvas.drawCircle(keyholeCenter, w * 0.07, keyholePaint);
    canvas.drawRect(
      Rect.fromLTWH(
        keyholeCenter.dx - w * 0.035,
        keyholeCenter.dy,
        w * 0.07,
        h * 0.14,
      ),
      keyholePaint,
    );
  }

  @override
  bool shouldRepaint(covariant PadlockPainter oldDelegate) {
    return oldDelegate.bodyColor != bodyColor ||
        oldDelegate.shackleColor != shackleColor;
  }
}
