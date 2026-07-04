import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: cs.primary.withValues(alpha: .12),
          child: Icon(Icons.security, color: cs.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(loc.dashboardWelcome, style: tt.bodyMedium),
              Text(
                loc.dashboardHelloUser,
                style: tt.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search, color: cs.primary),
        ),
      ],
    );
  }
}
