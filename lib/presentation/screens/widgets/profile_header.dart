import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? imageUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: cs.outlineVariant),
          ),
          child: CircleAvatar(
            backgroundColor: cs.surfaceContainerHighest,
            backgroundImage: imageUrl == null ? null : NetworkImage(imageUrl!),
            child: imageUrl == null
                ? Icon(Icons.person, size: 36, color: cs.onSurfaceVariant)
                : null,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: tt.titleSmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: tt.bodySmall?.copyWith(
            color: cs.onSurfaceVariant,
            letterSpacing: .2,
          ),
        ),
      ],
    );
  }
}
