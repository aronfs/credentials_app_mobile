import 'package:flutter/material.dart';

/// Bloque de título + subtítulo con animación de entrada tipo
/// "fade + slide up", controlado por un progreso 0.0–1.0 independiente
/// para cada línea (para lograr el efecto escalonado).
class AnimatedBrandText extends StatelessWidget {
  final String title;
  final String subtitle;
  final double titleProgress;
  final double subtitleProgress;

  const AnimatedBrandText({
    super.key,
    required this.title,
    required this.subtitle,
    required this.titleProgress,
    required this.subtitleProgress,
  });

  Widget _fadeSlide({
    required Widget child,
    required double progress,
  }) {
    final double t = Curves.easeOut.transform(progress.clamp(0.0, 1.0));
    return Opacity(
      opacity: t,
      child: Transform.translate(
        offset: Offset(0, (1 - t) * 18),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _fadeSlide(
          progress: titleProgress,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Color(0xFF14162B),
              height: 1.15,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _fadeSlide(
          progress: subtitleProgress,
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF9A9DB0),
            ),
          ),
        ),
      ],
    );
  }
}
