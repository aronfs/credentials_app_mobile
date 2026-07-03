import 'package:archive_secure/domain/entities/dashboard_entity.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/presentation/dashboard/widgets/dashboard_helpers.dart';
import 'package:flutter/material.dart';

class TopCategoriesSection extends StatelessWidget {
  final List<DashboardCategoryEntity> categories;

  const TopCategoriesSection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.dashboardTopCategories,
          style: tt.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        if (categories.isEmpty)
          _EmptyCategoriesState(loc: loc)
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories
                .map((cat) => _CategoryChip(category: cat))
                .toList(),
          ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final DashboardCategoryEntity category;

  const _CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    final color = colorFromHex(category.color);
    final icon = iconFromString(category.icon);

    return InkWell(
      onTap: () {
        try {
          Navigator.pushNamed(context, '/categories/detail',
              arguments: category.id);
        } catch (_) {}
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              category.name,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${category.totalCredentials}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyCategoriesState extends StatelessWidget {
  final AppLocalizations loc;

  const _EmptyCategoriesState({required this.loc});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Icon(Icons.folder_outlined,
              size: 48,
              color: cs.onSurfaceVariant.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          Text(
            loc.dashboardNoCategories,
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          FilledButton.tonalIcon(
            onPressed: () =>
                Navigator.pushNamed(context, '/categoryFormPage'),
            icon: const Icon(Icons.add, size: 18),
            label: Text(loc.dashboardCreateCategory),
          ),
        ],
      ),
    );
  }
}
