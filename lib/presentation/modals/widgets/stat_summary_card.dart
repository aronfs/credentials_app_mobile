import 'package:flutter/material.dart';

/// Tarjeta de estadística: icono a la izquierda, badge de texto
/// (ej. "total", "favs") a la derecha, número grande y label debajo.
class StatSummaryCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String badgeLabel;
  final String value;
  final String label;

  const StatSummaryCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.badgeLabel,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEEF0F4), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, size: 18, color: iconColor),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F3F7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badgeLabel,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF9A9DB0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF9A9DB0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
