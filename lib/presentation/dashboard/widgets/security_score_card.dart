import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SecurityScoreCard extends StatelessWidget {
  final int score;

  const SecurityScoreCard({super.key, required this.score});

  String _status(AppLocalizations loc) {
    if (score >= 80) return loc.dashboardSecurityScoreSafe;
    if (score >= 50) return loc.dashboardSecurityScoreImproveable;
    return loc.dashboardSecurityScoreRisk;
  }

  Color _statusColor(ColorScheme cs) {
    if (score >= 80) return Colors.green;
    if (score >= 50) return Colors.orange;
    return cs.error;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;
    final statusColor = _statusColor(cs);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cs.surfaceContainerHighest.withValues(alpha: 0.6),
            cs.surfaceContainerHighest.withValues(alpha: 0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 8,
                    backgroundColor: cs.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation(statusColor),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Text(
                  '$score%',
                  style: tt.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.dashboardSecurityScore,
                  style: tt.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _status(loc),
                    style: tt.labelSmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  loc.dashboardSecurityScoreDescription,
                  style: tt.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
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
