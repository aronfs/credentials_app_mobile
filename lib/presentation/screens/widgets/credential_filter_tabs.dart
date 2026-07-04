import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CredentialFilterTabs extends StatelessWidget {
  final VoidCallback onCategoryTap;
  final VoidCallback onFavoriteTap;

  const CredentialFilterTabs({
    super.key,
    required this.onCategoryTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: _FilterTab(
            icon: Icons.folder_open_outlined,
            label: loc.credentialsFilterCategories,
            onTap: onCategoryTap,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _FilterTab(
            icon: Icons.star_border,
            label: loc.credentialsFilterFavorites,
            onTap: onFavoriteTap,
          ),
        ),
      ],
    );
  }
}

class _FilterTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FilterTab({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: cs.onSurfaceVariant),
              const SizedBox(width: 6),
              Text(
                label,
                style: tt.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
