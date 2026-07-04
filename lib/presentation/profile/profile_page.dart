import 'package:archive_secure/data/auth/bloc/auth_bloc.dart';
import 'package:archive_secure/data/auth/bloc/auth_event.dart';
import 'package:archive_secure/domain/entities/profile_entity.dart';
import 'package:archive_secure/presentation/profile/bloc/profile_bloc.dart';
import 'package:archive_secure/presentation/profile/bloc/profile_event.dart';
import 'package:archive_secure/presentation/profile/bloc/profile_state.dart';
import 'package:archive_secure/presentation/profile/widgets/change_password_form.dart';
import 'package:archive_secure/presentation/profile/widgets/change_pin_form.dart';
import 'package:archive_secure/presentation/profile/widgets/edit_profile_name_form.dart';
import 'package:archive_secure/presentation/profile/widgets/profile_header_card.dart';
import 'package:archive_secure/presentation/profile/widgets/profile_stats_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileRequested());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: _onStateChanged,
      builder: (context, state) {
        if (state is ProfileLoading || state is ProfileInitial) {
          return const _ProfileSkeleton();
        }
        if (state is ProfileFailure && state is! ProfileLoaded) {
          return _ErrorView(
            error: state.error,
            onRetry: () => bloc.add(const ProfileRequested()),
          );
        }
        if (state is ProfileLoaded ||
            state is ProfileUpdating ||
            state is ProfileActionSuccess) {
          final profile = state is ProfileLoaded
              ? state.profile
              : state is ProfileUpdating
                  ? state.profile
                  : state is ProfileActionSuccess
                      ? state.profile!
                      : null;
          if (profile == null) return const _ProfileSkeleton();
          final isLoading = state is ProfileUpdating;
          return _ProfileContent(
            profile: profile,
            isLoading: isLoading,
            onNameSave: (name) =>
                bloc.add(ProfileNameUpdated(name: name)),
            onPinSave: (currentPin, newPin) => bloc.add(
              ProfilePinChanged(currentPin: currentPin, newPin: newPin),
            ),
            onPasswordSave: (currentPassword, newPassword) => bloc.add(
              ProfilePasswordChanged(
                currentPassword: currentPassword,
                newPassword: newPassword,
              ),
            ),
          );
        }
        return const _ProfileSkeleton();
      },
    );
  }

  void _onStateChanged(BuildContext context, ProfileState state) {
    if (state is ProfileActionSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
    if (state is ProfileFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}

class _ProfileContent extends StatelessWidget {
  final ProfileEntity profile;
  final bool isLoading;
  final void Function(String name) onNameSave;
  final void Function(String currentPin, String newPin) onPinSave;
  final void Function(String currentPassword, String newPassword)
      onPasswordSave;

  const _ProfileContent({
    required this.profile,
    required this.isLoading,
    required this.onNameSave,
    required this.onPinSave,
    required this.onPasswordSave,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
      child: Column(
        children: [
          ProfileHeaderCard(user: profile.user),
          const SizedBox(height: 16),
          ProfileStatsCard(stats: profile.stats),
          const SizedBox(height: 20),
          EditProfileNameForm(
            currentName: profile.user.name,
            onSave: onNameSave,
            isLoading: isLoading,
          ),
          const SizedBox(height: 12),
          ChangePinForm(onSave: onPinSave, isLoading: isLoading),
          const SizedBox(height: 12),
          ChangePasswordForm(onSave: onPasswordSave, isLoading: isLoading),
          const SizedBox(height: 12),
          _SecuritySettingsTile(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () =>
                  context.read<AuthBloc>().add(const LogoutSubmitted()),
              icon: const Icon(Icons.logout),
              label: const Text('Cerrar sesión'),
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.error,
                foregroundColor: cs.onError,
                textStyle: const TextStyle(fontWeight: FontWeight.w900),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecuritySettingsTile extends StatelessWidget {
  const _SecuritySettingsTile();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.pushNamed(context, '/securityPage'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.security, color: cs.secondary, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ajustes de seguridad',
                        style: tt.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                      ),
                      Text(
                        'Biometría, PIN y más',
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileSkeleton extends StatelessWidget {
  const _ProfileSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded, size: 64, color: cs.error),
            const SizedBox(height: 16),
            Text(
              error,
              style: tt.bodyLarge?.copyWith(color: cs.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
