import 'package:flutter/material.dart';

/// Indicador de carga del splash: barra de progreso delgada que se
/// llena según [progress] (0.0–1.0), y texto en mayúsculas con puntos
/// suspensivos que animan continuamente (ej. "INICIANDO", "INICIANDO.",
/// "INICIANDO..", "INICIANDO...").
class SplashLoadingIndicator extends StatefulWidget {
  final double progress;
  final String label;
  final Color activeColor;
  final Color trackColor;

  const SplashLoadingIndicator({
    super.key,
    required this.progress,
    this.label = 'INICIANDO',
    this.activeColor = const Color(0xFF3D6BFF),
    this.trackColor = const Color(0xFFE7E9F0),
  });

  @override
  State<SplashLoadingIndicator> createState() =>
      _SplashLoadingIndicatorState();
}

class _SplashLoadingIndicatorState extends State<SplashLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _dotsController;

  @override
  void initState() {
    super.initState();
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Barra de progreso
        SizedBox(
          width: 96,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Stack(
              children: [
                Container(height: 4, color: widget.trackColor),
                FractionallySizedBox(
                  widthFactor: widget.progress.clamp(0.0, 1.0),
                  child: Container(height: 4, color: widget.activeColor),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Texto + 3 puntos con opacidad animada en fase (ancho fijo,
        // sin saltos de layout).
        AnimatedBuilder(
          animation: _dotsController,
          builder: (context, child) {
            const textStyle = TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9A9DB0),
              letterSpacing: 2,
            );
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.label, style: textStyle),
                ...List.generate(3, (i) {
                  final double phase =
                      (_dotsController.value - (i * 0.15)) % 1.0;
                  final double opacity =
                      phase < 0.5 ? (phase * 2).clamp(0.0, 1.0) : 1.0;
                  return Opacity(
                    opacity: phase < 0 ? 0.2 : (0.2 + opacity * 0.8),
                    child: Text('.', style: textStyle),
                  );
                }),
              ],
            );
          },
        ),
      ],
    );
  }
}
