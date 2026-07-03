import 'package:archive_secure/domain/entities/credential_entity.dart';
import 'package:archive_secure/utils/credential_helpers.dart';
import 'package:flutter/material.dart';

class FavoriteCredentialCard extends StatelessWidget {
  final CredentialEntity credential;
  final VoidCallback onRemove;
  final VoidCallback? onToggle;
  final VoidCallback? onTap;

  const FavoriteCredentialCard({
    super.key,
    required this.credential,
    required this.onRemove,
    this.onToggle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final identifier = credentialIdentifier(credential);
    final date = credential.favoriteAt ?? credential.updatedAt;
    final dateText = formatRelativeDate(date);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cs.secondary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    credential.serviceName.isNotEmpty
                        ? credential.serviceName[0].toUpperCase()
                        : '?',
                    style: tt.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: cs.secondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      credential.serviceName,
                      style: tt.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      identifier,
                      style: tt.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (credential.strength != null) ...[
                          _StrengthBadge(
                              strength: credential.strength!, cs: cs, tt: tt),
                          const SizedBox(width: 8),
                        ],
                        if (credential.tags.isNotEmpty) ...[
                          ...credential.tags.take(2).map(
                                (tag) => Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: cs.surfaceContainerHighest,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      tag,
                                      style: tt.labelSmall?.copyWith(
                                        color: cs.onSurfaceVariant,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        ],
                        const Spacer(),
                        Text(
                          dateText,
                          style: tt.labelSmall?.copyWith(
                            color: cs.onSurfaceVariant,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onRemove,
                icon: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 22,
                ),
                tooltip: 'Quitar de favoritos',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StrengthBadge extends StatelessWidget {
  final int strength;
  final ColorScheme cs;
  final TextTheme tt;

  const _StrengthBadge({
    required this.strength,
    required this.cs,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    final color = strength >= 80
        ? Colors.green
        : strength >= 50
            ? Colors.amber
            : Colors.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$strength',
        style: tt.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
      ),
    );
  }
}
