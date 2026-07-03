import 'package:archive_secure/presentation/modals/models/credential_entry.dart';
import 'package:flutter/material.dart';


/// Fila de credencial reciente: icono cuadrado a la izquierda, nombre
/// y usuario/correo, y botón de menú "⋮" a la derecha.
class CredentialRow extends StatelessWidget {
  final CredentialEntry entry;
  final VoidCallback? onTap;
  final VoidCallback? onMenuTap;

  const CredentialRow({
    super.key,
    required this.entry,
    this.onTap,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEEF0F4), width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: entry.iconBackgroundColor,
                  borderRadius: BorderRadius.circular(11),
                ),
                alignment: Alignment.center,
                child: Icon(entry.icon, size: 19, color: entry.iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      entry.name,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      entry.username,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF9A9DB0),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onMenuTap,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.more_vert,
                    size: 18,
                    color: Color(0xFFB7BAC6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
