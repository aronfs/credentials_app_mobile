import 'package:archive_secure/data/dashboard/bloc/dashboard_cubit.dart';
import 'package:archive_secure/data/dashboard/data/dashboard_models.dart';
import 'package:archive_secure/presentation/screens/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: cs.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state.status == DashboardStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == DashboardStatus.error) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cloud_off, size: 64, color: cs.error),
                      const SizedBox(height: 16),
                      Text(state.error ?? 'Error', style: tt.bodyLarge?.copyWith(color: cs.error)),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () => context.read<DashboardCubit>().load(),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state.status == DashboardStatus.success && state.data != null) {
              return _DashboardContent(data: state.data!);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final DashboardMainModel data;

  const _DashboardContent({required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeader(),
          const SizedBox(height: 24),
          _SummaryCardsRow(summary: data.summary),
          const SizedBox(height: 24),
          if (data.securityAlerts.isNotEmpty) ...[
            _SecurityAlertsSection(alerts: data.securityAlerts),
            const SizedBox(height: 24),
          ],
          if (data.favoriteCredentials.isNotEmpty) ...[
            Text(
              'Credenciales Favoritas',
              style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: cs.onSurface),
            ),
            const SizedBox(height: 12),
            _FavoriteCredentialsList(credentials: data.favoriteCredentials),
            const SizedBox(height: 24),
          ],
          Text(
            'Últimas agregadas',
            style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: cs.onSurface),
          ),
          const SizedBox(height: 12),
          if (data.recentCredentials.isEmpty)
            _EmptyState(
              icon: Icons.lock_outline,
              message: 'Aún no tienes credenciales. Crea tu primera credencial segura.',
            )
          else
            ...data.recentCredentials.map((cred) => _RecentCredentialTile(credential: cred)),
          const SizedBox(height: 24),
          if (data.topCategories.isNotEmpty) ...[
            Text(
              'Categorías principales',
              style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: cs.onSurface),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: data.topCategories
                  .map((cat) => _CategoryChip(category: cat))
                  .toList(),
            ),
          ],
          const SizedBox(height: 24),
          Row(
            children: [
              _QuickAccessCard(
                icon: Icons.password,
                label: 'Generar contraseña',
                color: cs.tertiary,
                onTap: () {},
              ),
              const SizedBox(width: 12),
              _QuickAccessCard(
                icon: Icons.person,
                label: 'Mi perfil',
                color: cs.secondary,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryCardsRow extends StatelessWidget {
  final DashboardSummaryModel summary;

  const _SummaryCardsRow({required this.summary});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(child: _SummaryCard(
          icon: Icons.lock_outline,
          label: 'Credenciales',
          value: summary.totalCredentials.toString(),
          color: cs.primary,
        )),
        const SizedBox(width: 8),
        Expanded(child: _SummaryCard(
          icon: Icons.folder_outlined,
          label: 'Categorías',
          value: summary.totalCategories.toString(),
          color: cs.secondary,
        )),
        const SizedBox(width: 8),
        Expanded(child: _SummaryCard(
          icon: Icons.star_outline,
          label: 'Favoritos',
          value: summary.totalFavorites.toString(),
          color: Colors.amber.shade600,
        )),
        const SizedBox(width: 8),
        Expanded(child: _SummaryCard(
          icon: Icons.shield_outlined,
          label: 'Seguridad',
          value: '${summary.averageSecurityScore}%',
          color: summary.averageSecurityScore >= 60 ? Colors.green.shade600 : Colors.orange.shade600,
        )),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _SecurityAlertsSection extends StatelessWidget {
  final List<SecurityAlertModel> alerts;

  const _SecurityAlertsSection({required this.alerts});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded, size: 20, color: Colors.orange.shade600),
            const SizedBox(width: 8),
            Text(
              'Alertas de seguridad',
              style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: cs.onSurface),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...alerts.map((alert) {
          final color = alert.severity == 'high'
              ? cs.error
              : alert.severity == 'medium'
                  ? Colors.orange.shade600
                  : cs.onSurfaceVariant;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 18, color: color),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(alert.message, style: tt.bodyMedium?.copyWith(color: cs.onSurface)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${alert.count}',
                    style: tt.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _FavoriteCredentialsList extends StatelessWidget {
  final List<DashboardFavoriteCredentialModel> credentials;

  const _FavoriteCredentialsList({required this.credentials});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      children: credentials.map((cred) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.amber.shade600, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cred.serviceName, style: tt.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600, color: cs.onSurface,
                    )),
                    if (cred.loginEmail != null || cred.username != null)
                      Text(
                        cred.loginEmail ?? cred.username ?? '',
                        style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _RecentCredentialTile extends StatelessWidget {
  final DashboardRecentCredentialModel credential;

  const _RecentCredentialTile({required this.credential});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
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
            child: Icon(Icons.vpn_key_outlined, size: 18, color: cs.onPrimaryContainer),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(credential.serviceName, style: tt.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600, color: cs.onSurface,
                )),
                if (credential.loginEmail != null || credential.username != null)
                  Text(
                    credential.loginEmail ?? credential.username ?? '',
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Icon(
            credential.isFavorite ? Icons.star : Icons.star_border,
            color: credential.isFavorite ? Colors.amber.shade600 : cs.onSurfaceVariant,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final DashboardCategoryModel category;

  const _CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    final color = Color(
      int.tryParse(category.color.replaceFirst('#', '0xFF')) ?? 0xFF6366F1,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.folder_outlined, size: 14, color: color),
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
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;

  const _EmptyState({required this.icon, required this.message});

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
          Icon(icon, size: 48, color: cs.onSurfaceVariant.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          Text(message, style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}