import 'package:flutter/material.dart';

/// Campo de texto multilinea (textarea) con label encima. Usado para
/// campos largos como "Notas adicionales".
class LabeledTextArea extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final int minLines;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const LabeledTextArea({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.minLines = 3,
    this.maxLines = 5,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF9A9DB0),
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E2EA), width: 1.2),
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            minLines: minLines,
            maxLines: maxLines,
            style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0xFFB7BAC6),
                fontSize: 13.5,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
        ),
      ],
    );
  }
}
