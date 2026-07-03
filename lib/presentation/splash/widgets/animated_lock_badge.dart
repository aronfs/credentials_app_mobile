import 'package:flutter/material.dart';
import 'padlock_painter.dart';

/// Badge circular con icono de candado bicolor, animado:
/// - Entrada: escala con efecto "bounce" (overshoot elástico) + fade-in.
/// - Continuo: halo pulsante detrás del círculo, una vez visible.
///
/// [entranceProgress] (0.0–1.0) controla la animación de entrada,
/// normalmente derivada de un [AnimationController] padre mediante un
/// [Interval].
class AnimatedLockBadge extends StatefulWidget {
  final double entranceProgress;
  final double size;
  final Color badgeColor;
  final Color lockBodyColor;
  final Color lockShackleColor;

  const AnimatedLockBadge({
    super.key,
    required this.entranceProgress,
    this.size = 96,
    this.badgeColor = Colors.white,
    this.lockBodyColor = const Color(0xFF14162B),
    this.lockShackleColor = const Color(0xFF3D6BFF),
  });

  @override
  State<AnimatedLockBadge> createState() => _AnimatedLockBadgeState();
}

class _AnimatedLockBadgeState extends State<AnimatedLockBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double t = widget.entranceProgress.clamp(0.0, 1.0);
    // Overshoot elástico para el efecto "bounce" de entrada.
    final double entryScale = Curves.elasticOut.transform(t);
    final double entryOpacity = Curves.easeOut.transform(t);
    // Rotación sutil de entrada (de -8° a 0°).
    final double entryRotation = (1 - Curves.easeOut.transform(t)) * -0.14;

    return Opacity(
      opacity: entryOpacity,
      child: Transform.rotate(
        angle: entryRotation,
        child: Transform.scale(
          scale: 0.3 + (entryScale * 0.7),
          child: AnimatedBuilder(
            animation: _pulse,
            builder: (context, child) {
              final double haloScale = 1.0 + (_pulse.value * 0.2);
              final double haloOpacity = (1.0 - _pulse.value) * 0.3;
              return SizedBox(
                width: widget.size * 1.8,
                height: widget.size * 1.8,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Halo pulsante
                    Transform.scale(
                      scale: haloScale,
                      child: Container(
                        width: widget.size,
                        height: widget.size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.lockShackleColor
                              .withOpacity(haloOpacity),
                        ),
                      ),
                    ),
                    // Badge circular blanco con sombra
                    Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                        color: widget.badgeColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(widget.size * 0.26),
                      child: CustomPaint(
                        painter: PadlockPainter(
                          bodyColor: widget.lockBodyColor,
                          shackleColor: widget.lockShackleColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
