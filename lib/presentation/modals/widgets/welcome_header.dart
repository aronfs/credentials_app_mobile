import 'package:flutter/material.dart';

/// Header de bienvenida: avatar circular con iniciales a la izquierda,
/// saludo "Bienvenido," + nombre en negrita, y botón lupa a la derecha.
class WelcomeHeader extends StatelessWidget {
  final String userName;
  final String avatarInitials;
  final Color avatarColor;
  final VoidCallback? onSearchTap;

  const WelcomeHeader({
    super.key,
    required this.userName,
    required this.avatarInitials,
    this.avatarColor = const Color(0xFF3D5AFE),
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar circular con iniciales
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: avatarColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            avatarInitials,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Saludo
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bienvenido,',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF9A9DB0),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Hola, $userName',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
        ),
        // Botón lupa
        Material(
          color: const Color(0xFFF2F3F7),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onSearchTap,
            child: const SizedBox(
              width: 42,
              height: 42,
              child: Icon(Icons.search, size: 20, color: Color(0xFF1A1A2E)),
            ),
          ),
        ),
      ],
    );
  }
}
