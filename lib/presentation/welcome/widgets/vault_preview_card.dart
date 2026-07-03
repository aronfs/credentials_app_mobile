import 'package:flutter/material.dart';
import 'vault_folder_chip.dart';
import 'vault_search_field.dart';

/// Card de previsualización de la bóveda usada en el onboarding:
/// campo de búsqueda decorativo + fila de chips de carpeta.
/// Fondo blanco con sombra sutil.
class VaultPreviewCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<FolderDef> folders;

  const VaultPreviewCard({
    super.key,
    required this.title ,
    required this.subtitle,
    this.folders = const [],
  });

  List<FolderDef> get _defaultFolders => [
        FolderDef(
          icon: Icons.star,
          iconColor: const Color(0xFF3D5AFE),
          label: title,
        ),
        FolderDef(
          icon: Icons.folder_outlined,
          iconColor: const Color(0xFF4A4D5E),
          label: subtitle,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final items = folders.isEmpty ? _defaultFolders : folders;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const VaultSearchField(),
          const SizedBox(height: 12),
          Row(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                VaultFolderChip(
                  icon: items[i].icon,
                  iconColor: items[i].iconColor,
                  label: items[i].label,
                ),
                if (i != items.length - 1) const SizedBox(width: 10),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class FolderDef {
  final IconData icon;
  final Color iconColor;
  final String label;

  const FolderDef({
    required this.icon,
    required this.iconColor,
    required this.label,
  });
}