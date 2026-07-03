import 'package:flutter/material.dart';

/// Separador horizontal con texto centrado (ej. "O"), usado entre
/// el botón de login y las opciones alternativas.
class DividerWithLabel extends StatelessWidget {
  final String label;

  const DividerWithLabel({super.key, this.label = 'O'});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color(0xFFE0E2EA),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFFB7BAC6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Color(0xFFE0E2EA),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
