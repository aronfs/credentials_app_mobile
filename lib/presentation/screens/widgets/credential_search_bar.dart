import 'package:flutter/material.dart';

class CredentialSearchBar extends StatelessWidget {
  const CredentialSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Buscar credenciales, notas, bancos...',
        filled: true,
        fillColor: cs.surfaceContainerHighest.withValues(alpha: .45),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
      ),
    );
  }
}
