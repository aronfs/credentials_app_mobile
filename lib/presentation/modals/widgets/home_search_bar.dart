import 'package:flutter/material.dart';

/// Campo de búsqueda de ancho completo con icono de lupa y placeholder.
/// Fondo blanco con borde sutil.
class HomeSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  const HomeSearchBar({
    super.key,
    this.hintText = 'Buscar...',
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEEF0F4), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 19, color: Color(0xFFB7BAC6)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onTap: onTap,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0xFFB7BAC6),
                  fontSize: 14.5,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
              style: const TextStyle(fontSize: 14.5, color: Color(0xFF1A1A2E)),
            ),
          ),
        ],
      ),
    );
  }
}
