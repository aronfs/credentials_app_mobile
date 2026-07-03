import 'package:flutter/material.dart';

class CredentialItemData {
  final String title;
  final String subtitle;
  final String passwordText;
  final bool isPasswordRevealed;
  final IconData icon;
  final bool isFavorite;

  const CredentialItemData({
    required this.title,
    required this.subtitle,
    required this.passwordText,
    required this.isPasswordRevealed,
    required this.icon,
    required this.isFavorite,
  });
}

class CredentialListItem extends StatelessWidget {
  final CredentialItemData data;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTogglePassword;

  const CredentialListItem({
    super.key,
    required this.data,
    required this.onTap,
    required this.onToggleFavorite,
    required this.onTogglePassword,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: Column(
          children: [
            Row(
              children: [
                _CredentialIcon(icon: data.icon),
                const SizedBox(width: 12),
                Expanded(
                  child: _CredentialTexts(
                    title: data.title,
                    subtitle: data.subtitle,
                  ),
                ),
                IconButton(
                  onPressed: onToggleFavorite,
                  icon: Icon(
                    data.isFavorite ? Icons.star : Icons.star_border,
                    color: data.isFavorite ? Colors.amber : cs.outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest.withValues(alpha: .55),
                borderRadius: BorderRadius.circular(7),
                border:
                    Border.all(color: cs.outlineVariant.withValues(alpha: .6)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      data.passwordText,
                      style: tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: data.isPasswordRevealed ? 0 : 3,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onTogglePassword,
                    icon: Icon(
                      data.isPasswordRevealed
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 18,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CredentialIcon extends StatelessWidget {
  final IconData icon;

  const _CredentialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: cs.primaryContainer.withValues(alpha: .35),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: cs.primary),
    );
  }
}

class _CredentialTexts extends StatelessWidget {
  final String title;
  final String subtitle;

  const _CredentialTexts({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: tt.titleSmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: cs.onSurface,
          ),
        ),
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: tt.bodySmall?.copyWith(
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
