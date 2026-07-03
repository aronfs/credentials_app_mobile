import 'package:flutter/material.dart';

/// Encabezado de formulario con título grande centrado y subtítulo
/// descriptivo. Variante sin icono, para pantallas como Registro.
class FormPageHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const FormPageHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13.5,
            color: Color(0xFF9A9DB0),
          ),
        ),
      ],
    );
  }
}
