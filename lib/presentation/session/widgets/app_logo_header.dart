import 'package:flutter/material.dart';

/// Cabecera de app en pantalla de login: icono grande centrado,
/// nombre de la app en negrita y subtítulo descriptivo.
class AppLogoHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String appName;
  final String subtitle;
  final double iconSize;

  const AppLogoHeader({
    super.key,
    required this.icon,
    required this.appName,
    this.subtitle = '',
    this.iconColor = const Color(0xFF5C6BC0),
    this.iconSize = 52,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: iconSize, color: iconColor),
        const SizedBox(height: 12),
        Text(
          appName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
          ),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13.5,
              color: Color(0xFF9A9DB0),
            ),
          ),
        ],
      ],
    );
  }
}
