import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FavoritesEmptyState extends StatelessWidget {
  final bool isSearchEmpty;
  final String? searchQuery;

  const FavoritesEmptyState({
    super.key,
    this.isSearchEmpty = false,
    this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSearchEmpty ? Icons.search_off : Icons.star_border,
              size: 72,
              color: cs.onSurfaceVariant.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 20),
            Text(
              isSearchEmpty ? loc.favoritesNoResults : loc.favoritesEmpty,
              style: tt.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              isSearchEmpty
                  ? loc.favoritesNoResultsHint
                  : loc.favoritesEmptyHint,
              style: tt.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
