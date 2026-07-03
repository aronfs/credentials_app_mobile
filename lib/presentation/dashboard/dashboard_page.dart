import 'package:archive_secure/domain/entities/dashboard_entity.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:archive_secure/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:archive_secure/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:archive_secure/presentation/dashboard/widgets/dashboard_summary_card.dart';
import 'package:archive_secure/presentation/dashboard/widgets/favorite_credentials_section.dart';
import 'package:archive_secure/presentation/dashboard/widgets/recent_credentials_section.dart';
import 'package:archive_secure/presentation/dashboard/widgets/security_alerts_section.dart';
import 'package:archive_secure/presentation/dashboard/widgets/security_score_card.dart';
import 'package:archive_secure/presentation/dashboard/widgets/top_categories_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(const DashboardRequested());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading && state is! DashboardLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DashboardFailure) {
              return _ErrorView(
                error: state.error,
                onRetry: () =>
                    context.read<DashboardBloc>().add(const DashboardRequested()),
              );
            }
            if (state is DashboardLoaded) {
              return _DashboardContent(
                data: state.data,
                onRefresh: () =>
                    context.read<DashboardBloc>().add(const DashboardRefreshed()),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final DashboardEntity data;
  final VoidCallback onRefresh;

  const _DashboardContent({
    required this.data,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final summary = data.summary;
    final recentCredentials = data.recentCredentials;
    final favoriteCredentials = data.favoriteCredentials;
    final topCategories = data.topCategories;
    final securityAlerts = data.securityAlerts;

    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DashboardHeader(onRefresh: onRefresh),
            const SizedBox(height: 24),
            DashboardSummaryCard(summary: summary),
            const SizedBox(height: 20),
            SecurityScoreCard(score: summary.averageSecurityScore),
            const SizedBox(height: 24),
            SecurityAlertsSection(alerts: securityAlerts),
            const SizedBox(height: 24),
            FavoriteCredentialsSection(credentials: favoriteCredentials),
            const SizedBox(height: 24),
            RecentCredentialsSection(credentials: recentCredentials),
            const SizedBox(height: 24),
            TopCategoriesSection(categories: topCategories),
          ],
        ),
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  final VoidCallback onRefresh;

  const _DashboardHeader({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: cs.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(Icons.dashboard_rounded, color: cs.primary, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.dashboardTitle,
                style: tt.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: cs.onSurface,
                ),
              ),
              Text(
                loc.dashboardSubtitle,
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onRefresh,
          icon: Icon(Icons.refresh_rounded, color: cs.primary),
          tooltip: loc.dashboardRefresh,
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded, size: 64, color: cs.error),
            const SizedBox(height: 16),
            Text(
              error,
              style: tt.bodyLarge?.copyWith(color: cs.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(loc.dashboardRetry),
            ),
          ],
        ),
      ),
    );
  }
}
