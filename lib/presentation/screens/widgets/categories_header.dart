import 'package:flutter/material.dart';

class CategoriesHeader extends StatelessWidget {
  final VoidCallback onAddTap;

  const CategoriesHeader({super.key, required this.onAddTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categorías',
                style: tt.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Organiza tus credenciales de forma segura.',
                style: tt.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 56,
          height: 44,
          child: FilledButton(
            onPressed: onAddTap,
            style: FilledButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
