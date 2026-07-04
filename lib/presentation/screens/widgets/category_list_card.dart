import 'package:flutter/material.dart';

class CategoryListData {
  final String title;
  final String countText;
  final IconData icon;
  final Color color;

  const CategoryListData({
    required this.title,
    required this.countText,
    required this.icon,
    required this.color,
  });
}

class CategoryListCard extends StatelessWidget {
  final CategoryListData data;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const CategoryListCard({
    super.key,
    required this.data,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final toneColor = data.color;
    final bgColor = toneColor.withValues(alpha: .15);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cs.outlineVariant),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 4),
              color: cs.shadow.withValues(alpha: .08),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -16,
              left: -18,
              right: -18,
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  color: toneColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 38,
                  height: 34,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    data.icon,
                    size: 20,
                    color: toneColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data.title,
                  style: tt.titleSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest.withValues(alpha: .75),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    data.countText.isNotEmpty
                        ? '\u2318 ${data.countText}'
                        : '',
                    style: tt.labelMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                      letterSpacing: .2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}