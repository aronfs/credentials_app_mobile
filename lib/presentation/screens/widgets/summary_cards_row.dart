import 'package:flutter/material.dart';

import 'summary_card.dart';

class SummaryCardsRow extends StatelessWidget {
  const SummaryCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: SummaryCard(
            icon: Icons.vpn_key_outlined,
            label: 'Credenciales',
            value: '42',
            badge: 'total',
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: SummaryCard(
            icon: Icons.star,
            label: 'Favoritos',
            value: '8',
            badge: 'favs',
          ),
        ),
      ],
    );
  }
}
