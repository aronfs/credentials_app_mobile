import 'package:flutter/material.dart';

class HealthCard extends StatelessWidget {
  const HealthCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -12,
            child: Icon(
              Icons.shield_outlined,
              size: 96,
              color: cs.onPrimary.withValues(alpha: .14),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Salud de Seguridad',
                style: tt.titleSmall?.copyWith(
                  color: cs.onPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '85%',
                    style: tt.displaySmall?.copyWith(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Fuerte',
                      style: tt.bodyMedium?.copyWith(color: cs.onPrimary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: .85,
                backgroundColor: cs.onPrimary.withValues(alpha: .25),
                valueColor: AlwaysStoppedAnimation<Color>(cs.onPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
