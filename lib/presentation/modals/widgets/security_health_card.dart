import 'package:flutter/material.dart';

/// Card de "Salud de Seguridad": fondo con gradiente azul, título,
/// porcentaje grande + calificación textual (ej. "Fuerte"), barra de
/// progreso y un icono de escudo decorativo semitransparente al fondo.
class SecurityHealthCard extends StatelessWidget {
  final String title;
  final int percentage;
  final String rating;

  const SecurityHealthCard({
    super.key,
    this.title = 'Salud de Seguridad',
    required this.percentage,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3D5AFE), Color(0xFF5C6BC0)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D5AFE).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Icono de escudo decorativo
          Positioned(
            top: -6,
            right: -6,
            child: Icon(
              Icons.shield,
              size: 90,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.shield_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$percentage%',
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    rating,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Barra de progreso
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: [
                    Container(
                      height: 6,
                      color: Colors.white.withValues(alpha: 0.25),
                    ),
                    FractionallySizedBox(
                      widthFactor: (percentage / 100).clamp(0.0, 1.0),
                      child: Container(height: 6, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
