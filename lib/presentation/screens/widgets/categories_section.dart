import 'package:flutter/material.dart';

import 'category_card.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    final categories = [
      (Icons.public, 'Webs'),
      (Icons.account_balance, 'Bancos'),
      (Icons.work_outline, 'Trabajo'),
    ];

    return Column(
      children: [
        Row(
          children: [
            Text(
              'Categorías',
              style: tt.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text('Ver todas'),
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
