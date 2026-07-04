import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ProfileImageActions extends StatelessWidget {
  final bool hasImage;
  final VoidCallback onGallery;
  final VoidCallback onCamera;
  final VoidCallback? onDelete;

  const ProfileImageActions({
    super.key,
    required this.hasImage,
    required this.onGallery,
    required this.onCamera,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: cs.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              hasImage
                  ? loc.profileImageChange
                  : loc.profileImageNoPhoto,
              style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            _ActionTile(
              icon: Icons.photo_library_outlined,
              label: loc.profileImagePickGallery,
              onTap: () {
                Navigator.pop(context);
                onGallery();
              },
            ),
            const SizedBox(height: 4),
            _ActionTile(
              icon: Icons.camera_alt_outlined,
              label: loc.profileImagePickCamera,
              onTap: () {
                Navigator.pop(context);
                onCamera();
              },
            ),
            if (hasImage && onDelete != null) ...[
              const SizedBox(height: 4),
              _ActionTile(
                icon: Icons.delete_outline,
                label: loc.profileImageDelete,
                onTap: () {
                  Navigator.pop(context);
                  onDelete!();
                },
                isDestructive: true,
              ),
            ],
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
                color: isDestructive ? cs.error : cs.onSurface,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isDestructive ? cs.error : cs.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
