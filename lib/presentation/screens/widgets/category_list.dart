import 'package:archive_secure/data/categories/domain/entity/category.dart';
import 'package:flutter/material.dart';

import 'category_list_card.dart';

Color _colorFromHex(String hex) {
  try {
    final h = hex.replaceFirst('#', '');
    if (h.length == 6) return Color(int.parse('FF$h', radix: 16));
    if (h.length == 8) return Color(int.parse(h, radix: 16));
  } catch (_) {}
  return const Color(0xFF6366F1);
}

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final void Function(Category) onEdit;

  const CategoryList({
    super.key,
    required this.categories,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.folder_outlined,
                size: 48, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              'No hay categorías aún',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: categories.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (_, index) {
        final cat = categories[index];
        return CategoryListCard(
          data: CategoryListData(
            title: cat.name,
            countText: cat.totalCredentials.toString(),
            icon: _mapIcon(cat.icon),
            color: _colorFromHex(cat.color),
          ),
          onTap: () => onEdit(cat),
          onDelete: () {},
        );
      },
    );
  }

  IconData _mapIcon(String iconName) {
    switch (iconName) {
      case 'persona':
        return Icons.person_outline;
      case 'trabajo':
        return Icons.work_outline;
      case 'banco':
        return Icons.account_balance_outlined;
      case 'email':
        return Icons.mail_outline;
      case 'telefono':
        return Icons.phone_outlined;
      case 'wifi':
        return Icons.wifi;
      case 'estudio':
        return Icons.school_outlined;
      case 'shield':
        return Icons.shield_outlined;
      case 'cloud':
        return Icons.cloud_outlined;
      case 'star':
        return Icons.star_outline;
      case 'heart':
        return Icons.favorite_outline;
      default:
        return Icons.public;
    }
  }
}
