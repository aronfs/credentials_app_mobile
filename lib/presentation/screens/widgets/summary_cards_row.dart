import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'summary_card.dart';

class SummaryCardsRow extends StatelessWidget {
  const SummaryCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: SummaryCard(
            icon: Icons.vpn_key_outlined,
            label: loc.dashboardSummaryCredentials,
            value: '42',
            badge: 'total',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SummaryCard(
            icon: Icons.star,
            label: loc.dashboardSummaryFavorites,
            value: '8',
            badge: 'favs',
          ),
        ),
      ],
    );
  }
}
