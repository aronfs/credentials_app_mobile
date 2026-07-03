import 'package:archive_secure/domain/entities/dashboard_entity.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DashboardSummaryCard extends StatelessWidget {
  final DashboardSummaryEntity summary;

  const DashboardSummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: _SummaryCardItem(
            icon: Icons.lock_outline,
            label: loc.dashboardSummaryCredentials,
            value: summary.totalCredentials.toString(),
            color: cs.primary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _SummaryCardItem(
            icon: Icons.folder_outlined,
            label: loc.dashboardSummaryCategories,
            value: summary.totalCategories.toString(),
            color: cs.secondary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _SummaryCardItem(
            icon: Icons.star_outline,
            label: loc.dashboardSummaryFavorites,
            value: summary.totalFavorites.toString(),
            color: Colors.amber.shade600,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _SummaryCardItem(
            icon: Icons.history,
            label: loc.dashboardSummaryRecent,
            value: summary.totalRecentCredentials.toString(),
            color: Colors.teal.shade400,
          ),
        ),
      ],
    );
  }
}

class _SummaryCardItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _SummaryCardItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: tt.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
