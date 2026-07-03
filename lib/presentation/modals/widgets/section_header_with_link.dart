import 'package:flutter/material.dart';

/// Encabezado de sección con título en negrita a la izquierda y un
/// link de acción (ej. "Ver todas") a la derecha.
class SectionHeaderWithLink extends StatelessWidget {
  final String title;
  final String linkLabel;
  final VoidCallback? onLinkTap;

  const SectionHeaderWithLink({
    super.key,
    required this.title,
    this.linkLabel = 'Ver todas',
    this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
          ),
        ),
        GestureDetector(
          onTap: onLinkTap,
          child: Text(
            linkLabel,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3D5AFE),
            ),
          ),
        ),
      ],
    );
  }
}
