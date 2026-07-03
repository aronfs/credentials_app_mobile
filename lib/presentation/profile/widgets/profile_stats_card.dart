import 'package:archive_secure/domain/entities/profile_stats_entity.dart';
import 'package:flutter/material.dart';

class ProfileStatsCard extends StatelessWidget {
  final ProfileStatsEntity stats;

  const ProfileStatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(
            icon: Icons.lock_outline,
            value: '${stats.totalCredentials}',
            label: 'Credenciales',
            color: cs.secondary,
          ),
          _divider(cs),
          _StatItem(
            icon: Icons.folder_outlined,
            value: '${stats.totalCategories}',
            label: 'Categorías',
            color: cs.tertiary,
          ),
          _divider(cs),
          _StatItem(
            icon: Icons.star_outline,
            value: '${stats.totalFavorites}',
            label: 'Favoritos',
            color: Colors.amber,
          ),
        ],
      ),
    );
  }

  Widget _divider(ColorScheme cs) {
    return Container(
      width: 1,
      height: 40,
      color: cs.outlineVariant,
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 6),
        Text(
          value,
          style: tt.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        Text(
          label,
          style: tt.labelSmall?.copyWith(
            color: color.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
