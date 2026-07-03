import 'package:archive_secure/data/credentials/domain/entity/credential.dart';
import 'package:flutter/material.dart';

import 'credential_list_item.dart';

class CredentialList extends StatelessWidget {
  final List<Credential> credentials;
  final void Function(Credential) onEdit;
  final void Function(Credential) onViewPassword;
  final void Function(String) onHidePassword;
  final void Function(String) onToggleFavorite;
  final Map<String, String> revealedPasswords;

  const CredentialList({
    super.key,
    required this.credentials,
    required this.onEdit,
    required this.onViewPassword,
    required this.onHidePassword,
    required this.onToggleFavorite,
    required this.revealedPasswords,
  });

  @override
  Widget build(BuildContext context) {
    if (credentials.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.vpn_key_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              'No hay credenciales aún',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: credentials.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (_, index) {
        final cred = credentials[index];
        final revealed = revealedPasswords.containsKey(cred.id);
        return CredentialListItem(
          data: CredentialItemData(
            title: cred.serviceName,
            subtitle: cred.loginEmail ?? cred.username ?? '',
            passwordText:
                revealed ? revealedPasswords[cred.id]! : '••••••••••••',
            isPasswordRevealed: revealed,
            icon: _mapIcon(cred.serviceName),
            isFavorite: cred.isFavorite,
          ),
          onTap: () => onEdit(cred),
          onToggleFavorite: () => onToggleFavorite(cred.id),
          onTogglePassword: () {
            if (revealed) {
              onHidePassword(cred.id);
            } else {
              onViewPassword(cred);
            }
          },
        );
      },
    );
  }

  IconData _mapIcon(String serviceName) {
    final name = serviceName.toLowerCase();
    if (name.contains('gmail') ||
        name.contains('mail') ||
        name.contains('email')) {
      return Icons.mail_outline;
    }
    if (name.contains('github') || name.contains('git') || name.contains('code')) {
      return Icons.code;
    }
    if (name.contains('bank') ||
        name.contains('banco') ||
        name.contains('santander')) {
      return Icons.account_balance_outlined;
    }
    if (name.contains('amazon') ||
        name.contains('shop') ||
        name.contains('cart')) {
      return Icons.shopping_cart_outlined;
    }
    if (name.contains('twitter') ||
        name.contains('instagram') ||
        name.contains('social')) {
      return Icons.public;
    }
    return Icons.vpn_key_outlined;
  }
}
