import 'package:flutter/material.dart';

import 'credential_tile.dart';

class RecentCredentialsSection extends StatelessWidget {
  const RecentCredentialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CredentialTile(
          title: 'Gmail Personal',
          subtitle: 'usuario@gmail.com',
          icon: Icons.mail_outline,
        ),
        SizedBox(height: 8),
        CredentialTile(
          title: 'GitHub',
          subtitle: 'dev_user',
          icon: Icons.code,
        ),
      ],
    );
  }
}
