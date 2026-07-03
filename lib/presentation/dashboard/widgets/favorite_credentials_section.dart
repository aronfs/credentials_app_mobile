import 'package:archive_secure/domain/entities/dashboard_entity.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/presentation/dashboard/widgets/dashboard_helpers.dart';
import 'package:flutter/material.dart';

class FavoriteCredentialsSection extends StatelessWidget {
  final List<DashboardCredentialEntity> credentials;

  const FavoriteCredentialsSection({super.key, required this.credentials});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star, size: 20, color: Colors.amber.shade600),
            const SizedBox(width: 8),
            Text(
              loc.dashboardFavoriteCredentials,
              style: tt.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (credentials.isEmpty)
          _EmptyFavoritesState(loc: loc)
        else
          ...credentials.map((cred) => _FavoriteTile(
                credential: cred,
                loc: loc,
              )),
      ],
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  final DashboardCredentialEntity credential;
  final AppLocalizations loc;

  const _FavoriteTile({required this.credential, required this.loc});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          try {
            Navigator.pushNamed(context, '/credential-detail',
                arguments: credential.id);
          } catch (_) {}
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.star, color: Colors.amber.shade600, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      credential.serviceName,
                      style: tt.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                    ),
                    if (credential.loginEmail != null ||
                        credential.username != null)
                      Text(
                        credential.loginEmail ?? credential.username ?? '',
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    else
                      Text(
                        loc.dashboardNoIdentifier,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              if (credential.updatedAt != null)
                Text(
                  formatDashboardDate(credential.updatedAt, loc),
                  style: tt.labelSmall?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyFavoritesState extends StatelessWidget {
  final AppLocalizations loc;

  const _EmptyFavoritesState({required this.loc});

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
          Icon(Icons.star_border,
              size: 48,
              color: cs.onSurfaceVariant.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          Text(
            loc.dashboardNoFavorites,
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            loc.dashboardNoFavoritesHint,
            style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
