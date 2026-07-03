import 'package:flutter/material.dart';

/// Campo de búsqueda decorativo (no editable por defecto) usado dentro
/// de la card de bóveda en el onboarding. Muestra icono de lupa y
/// placeholder, con apariencia de input real pero como widget estático.
class VaultSearchField extends StatelessWidget {

  final VoidCallback? onTap;

  const VaultSearchField({
    super.key,
   
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F3F7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              size: 18,
              color: Color(0xFFB7BAC6),
            ),
            const SizedBox(width: 8),
            
          ],
        ),
      ),
    );
  }
}
