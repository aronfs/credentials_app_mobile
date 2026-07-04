import 'package:archive_secure/data/auth/bloc/auth_bloc.dart';
import 'package:archive_secure/data/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archive_secure/l10n/app_localizations.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: () {
          context.read<AuthBloc>().add(LogoutSubmitted());
        },
        icon: const Icon(Icons.logout),
        label: Text(loc.profileLogout),
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.error,
          foregroundColor: cs.onError,
          textStyle: const TextStyle(fontWeight: FontWeight.w900),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
    );
  }
}
