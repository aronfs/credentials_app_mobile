import 'package:archive_secure/features/profile_image/presentation/bloc/profile_image_bloc.dart';
import 'package:archive_secure/features/profile_image/presentation/bloc/profile_image_event.dart';
import 'package:archive_secure/features/profile_image/presentation/widgets/profile_image_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';

class ProfileAvatarWidget extends StatelessWidget {
  final Uint8List? imageBytes;
  final bool hasImage;
  final bool isLoading;
  final bool isDeleting;
  final String initials;
  final double size;

  const ProfileAvatarWidget({
    super.key,
    this.imageBytes,
    required this.hasImage,
    this.isLoading = false,
    this.isDeleting = false,
    required this.initials,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => _showOptions(context),
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: hasImage
                  ? null
                  : LinearGradient(
                      colors: [
                        cs.secondary,
                        cs.secondary.withValues(alpha: 0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              image: hasImage && imageBytes != null
                  ? DecorationImage(
                      image: MemoryImage(imageBytes!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: hasImage
                ? null
                : Center(
                    child: Text(
                      initials,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            color: cs.onSecondary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
          ),
          if (isLoading || isDeleting)
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.4),
              ),
              child: Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: cs.onPrimary,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.secondary,
                border: Border.all(color: cs.surface, width: 2),
              ),
              child: Icon(
                Icons.camera_alt,
                size: 14,
                color: cs.onSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOptions(BuildContext context) {
    final bloc = context.read<ProfileImageBloc>();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ProfileImageActions(
        hasImage: hasImage,
        onGallery: () =>
            bloc.add(const ProfileImagePickFromGalleryRequested()),
        onCamera: () => bloc.add(const ProfileImagePickFromCameraRequested()),
        onDelete: hasImage
            ? () {
                Navigator.pop(context);
                bloc.add(const ProfileImageDeleteRequested());
              }
            : null,
      ),
    );
  }
}
