import 'package:archive_secure/domain/entities/dashboard_entity.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SecurityAlertsSection extends StatelessWidget {
  final List<DashboardSecurityAlertEntity> alerts;

  const SecurityAlertsSection({super.key, required this.alerts});

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
            Icon(Icons.warning_amber_rounded,
                size: 20,
                color: alerts.isEmpty
                    ? Colors.green.shade600
                    : Colors.orange.shade600),
            const SizedBox(width: 8),
            Text(
              loc.dashboardSecurityAlerts,
              style: tt.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (alerts.isEmpty)
          _NoAlertsState(loc: loc)
        else
          ...alerts.map((alert) => _AlertTile(alert: alert)),
      ],
    );
  }
}

class _AlertTile extends StatelessWidget {
  final DashboardSecurityAlertEntity alert;

  const _AlertTile({required this.alert});

  Color _severityColor(ColorScheme cs) {
    switch (alert.severity?.toLowerCase()) {
      case 'high':
        return cs.error;
      case 'medium':
        return Colors.orange.shade600;
      case 'low':
        return Colors.blue.shade400;
      default:
        return cs.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final color = _severityColor(cs);

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
          Icon(
            alert.severity?.toLowerCase() == 'high'
                ? Icons.error_outline
                : Icons.info_outline,
            size: 18,
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (alert.title != null)
                  Text(
                    alert.title!,
                    style: tt.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
                  ),
                if (alert.message != null)
                  Text(
                    alert.message!,
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              alert.severity?.toUpperCase() ?? 'INFO',
              style: tt.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoAlertsState extends StatelessWidget {
  final AppLocalizations loc;

  const _NoAlertsState({required this.loc});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline,
              size: 28, color: Colors.green.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.dashboardNoAlerts,
                  style: tt.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                  ),
                ),
                Text(
                  loc.dashboardNoAlertsSubtitle,
                  style: tt.bodySmall?.copyWith(
                    color: Colors.green.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
