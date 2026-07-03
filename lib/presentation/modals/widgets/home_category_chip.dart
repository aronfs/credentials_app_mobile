import 'package:archive_secure/presentation/modals/models/home_category.dart';
import 'package:flutter/material.dart';


/// Chip cuadrado de categoría: icono circular grande arriba y nombre
/// debajo. Usado dentro de un [HomeCategoriesRow] horizontal.
class HomeCategoryChip extends StatelessWidget {
  final HomeCategory category;
  final VoidCallback? onTap;

  const HomeCategoryChip({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: 88,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFEEF0F4), width: 1),
          ),
          child: Column(
            children: [
              Icon(category.icon, size: 26, color: category.iconColor),
              const SizedBox(height: 10),
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fila horizontal scrollable de [HomeCategoryChip].
class HomeCategoriesRow extends StatelessWidget {
  final List<HomeCategory> categories;
  final ValueChanged<HomeCategory>? onCategoryTap;

  const HomeCategoriesRow({
    super.key,
    required this.categories,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          return HomeCategoryChip(
            category: category,
            onTap: () => onCategoryTap?.call(category),
          );
        },
      ),
    );
  }
}
