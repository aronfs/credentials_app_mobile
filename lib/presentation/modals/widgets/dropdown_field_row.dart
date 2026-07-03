import 'package:flutter/material.dart';

/// Campo tipo dropdown: label encima, icono + valor seleccionado +
/// chevron hacia abajo. Mismo estilo de borde que [RegisterTextField].
class DropdownFieldRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  final VoidCallback? onTap;

  const DropdownFieldRow({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    this.onTap,
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
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 13,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E2EA), width: 1.2),
              ),
              child: Row(
                children: [
                  Icon(icon, size: 17, color: const Color(0xFFB7BAC6)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: Color(0xFFB7BAC6),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
