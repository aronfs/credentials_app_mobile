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
              isSearchEmpty ? 'No se encontraron favoritos' : 'Aún no tienes favoritos',
              style: tt.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              isSearchEmpty
                  ? 'Intenta buscar con otro servicio, email o usuario.'
                  : 'Marca una credencial con estrella para verla aquí.',
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
