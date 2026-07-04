import 'package:archive_secure/navigation/route.dart';
import 'package:archive_secure/presentation/splash/widgets/animated_brand_text.dart';
import 'package:archive_secure/presentation/splash/widgets/animated_lock_badge.dart';
import 'package:archive_secure/presentation/splash/widgets/splash_loading_indicator.dart';
import 'package:flutter/material.dart';

/// Splash screen animado de "Archivero Seguro".
///
/// Orquesta una única línea de tiempo (duración configurable, por
/// defecto 6 segundos, dentro del rango recomendado 5-7s) que anima
/// en secuencia: el candado (bounce + fade), el título, el subtítulo,
/// y finalmente llena la barra de progreso mientras el texto
/// "INICIANDO..." parpadea. Al finalizar, verifica si hay sesión
/// guardada para decidir la siguiente pantalla.
class SplasPage extends StatefulWidget {
  final Duration duration;

  const SplasPage({
    super.key,
    this.duration = const Duration(seconds: 6),
  });

  @override
  State<SplasPage> createState() => _SplasPageState();
}

class _SplasPageState extends State<SplasPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _timeline;

  // Intervalos de la línea de tiempo (fracciones de 0.0 a 1.0 sobre
  // la duración total). Ajustar estos valores cambia el ritmo de la
  // animación sin tocar la duración total.
  static const Interval _lockInterval = Interval(0.0, 0.22, curve: Curves.linear);
  static const Interval _titleInterval = Interval(0.18, 0.38, curve: Curves.linear);
  static const Interval _subtitleInterval = Interval(0.32, 0.5, curve: Curves.linear);
  static const Interval _progressInterval = Interval(0.42, 1.0, curve: Curves.linear);

  @override
  void initState() {
    super.initState();
    _timeline = AnimationController(vsync: this, duration: widget.duration)
      ..forward();

    _timeline.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkSessionAndNavigate();
      }
    });
  }

  void _checkSessionAndNavigate() {
    Navigator.pushReplacementNamed(context, signInPage);
  }

  @override
  void dispose() {
    _timeline.dispose();
    super.dispose();
  }

  double _progressFor(Interval interval) {
    return interval.transform(_timeline.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Barra superior estilo browser (opcional, decorativa)
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                children: [
                  Icon(Icons.tv_outlined, size: 16, color: Colors.white54),
                  SizedBox(width: 6),
                  Text(
                    'Splash Screen',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Card principal
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: AnimatedBuilder(
                    animation: _timeline,
                    builder: (context, child) {
                      return Column(
                        children: [
                          const Spacer(flex: 3),

                          AnimatedLockBadge(
                            entranceProgress: _progressFor(_lockInterval),
                          ),
                          const SizedBox(height: 32),

                          AnimatedBrandText(
                            title: 'Archivero\nSeguro',
                            subtitle: 'Tus credenciales protegidas',
                            titleProgress: _progressFor(_titleInterval),
                            subtitleProgress:
                                _progressFor(_subtitleInterval),
                          ),

                          const Spacer(flex: 4),

                          Opacity(
                            opacity:
                                _progressFor(_progressInterval) > 0 ? 1 : 0,
                            child: SplashLoadingIndicator(
                              progress: _progressFor(_progressInterval),
                            ),
                          ),
                          const SizedBox(height: 28),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}