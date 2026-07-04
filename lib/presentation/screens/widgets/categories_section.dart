import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'category_card.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    final categories = [
      (Icons.public, loc.homeWebs),
      (Icons.account_balance, loc.homeBanks),
      (Icons.work_outline, loc.homeWork),
    ];

    return Column(
      children: [
        Row(
          children: [
            Text(
              loc.homeCategories,
              style: tt.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(loc.dashboardViewAll),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 104,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, index) {
              final item = categories[index];
              return CategoryCard(icon: item.$1, title: item.$2);
            },
          ),
        ),
      ],
    );
  }
}
