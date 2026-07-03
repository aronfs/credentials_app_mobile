import 'package:archive_secure/domain/entities/dashboard_entity.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/presentation/dashboard/widgets/dashboard_helpers.dart';
import 'package:flutter/material.dart';

class RecentCredentialsSection extends StatelessWidget {
  final List<DashboardCredentialEntity> credentials;

  const RecentCredentialsSection({super.key, required this.credentials});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.dashboardRecentCredentials,
          style: tt.titleMedium
              ?.copyWith(fontWeight: FontWeight.w800, color: cs.onSurface),
        ),
        const SizedBox(height: 12),
        if (credentials.isEmpty)
          _EmptyCredentialState(
            icon: Icons.lock_outline,
            message: loc.dashboardNoCredentials,
            actionLabel: loc.dashboardAddCredential,
            onAction: () =>
                Navigator.pushNamed(context, '/credentialFormPage'),
          )
        else
          ...credentials.map(
            (cred) => _CredentialTile(
              credential: cred,
              loc: loc,
              onTap: () {
                try {
                  Navigator.pushNamed(context, '/credential-detail',
                      arguments: cred.id);
                } catch (_) {}
              },
            ),
          ),
      ],
    );
  }
}

class _CredentialTile extends StatelessWidget {
  final DashboardCredentialEntity credential;
  final AppLocalizations loc;
  final VoidCallback? onTap;

  const _CredentialTile({
    required this.credential,
    required this.loc,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
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
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.vpn_key_outlined,
                    size: 18, color: cs.onPrimaryContainer),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (credential.isFavorite)
                    Icon(Icons.star, color: Colors.amber.shade600, size: 16),
                  const SizedBox(height: 4),
                  Text(
                    formatDashboardDate(credential.createdAt, loc),
                    style: tt.labelSmall?.copyWith(
                      color: cs.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyCredentialState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  const _EmptyCredentialState({
    required this.icon,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

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
          Icon(icon, size: 48,
              color: cs.onSurfaceVariant.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          Text(
            message,
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          FilledButton.tonalIcon(
            onPressed: onAction,
            icon: const Icon(Icons.add, size: 18),
            label: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}
