import 'package:archive_secure/core/services/biometric_auth_service.dart';
import 'package:archive_secure/core/services/biometric_preferences_service.dart';
import 'package:archive_secure/core/theme/theme_mode_controller.dart';
import 'package:archive_secure/data/auth/bloc/auth_bloc.dart';
import 'package:archive_secure/data/auth/bloc/auth_event.dart';
import 'package:archive_secure/domain/entities/profile_entity.dart';
import 'package:archive_secure/features/profile_image/presentation/bloc/profile_image_bloc.dart';
import 'package:archive_secure/features/profile_image/presentation/bloc/profile_image_event.dart';
import 'package:archive_secure/features/profile_image/presentation/bloc/profile_image_state.dart';
import 'package:archive_secure/features/profile_image/presentation/widgets/profile_avatar_widget.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
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
    context.read<ProfileImageBloc>().add(const ProfileImageStarted());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    final loc = AppLocalizations.of(context)!;

    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileImageBloc, ProfileImageState>(
          listener: (context, state) {
            if (state is ProfileImageUploadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(loc.profileImageUpdated)),
              );
            }
            if (state is ProfileImageDeleteSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(loc.profileImageDeleted)),
              );
            }
            if (state is ProfileImageFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          },
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
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
          },
        ),
      ],
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          Widget body;
          if (state is ProfileLoading || state is ProfileInitial) {
            body = const _ProfileSkeleton();
          } else if (state is ProfileFailure && state is! ProfileLoaded) {
            body = _ErrorView(
              error: state.error,
              onRetry: () => bloc.add(const ProfileRequested()),
            );
          } else if (state is ProfileLoaded ||
              state is ProfileUpdating ||
              state is ProfileActionSuccess) {
            final profile = state is ProfileLoaded
                ? state.profile
                : state is ProfileUpdating
                    ? state.profile
                    : state is ProfileActionSuccess
                        ? state.profile!
                        : null;
            if (profile == null) {
              body = const _ProfileSkeleton();
            } else {
              final isLoading = state is ProfileUpdating;
              body = _ProfileContent(
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
          } else {
            body = const _ProfileSkeleton();
          }
          return SafeArea(child: body);
        },
      ),
    );
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
    final loc = AppLocalizations.of(context)!;
    final initials = profile.user.name.isNotEmpty
        ? profile.user.name
            .split(' ')
            .map((e) => e.isNotEmpty ? e[0] : '')
            .take(2)
            .join()
            .toUpperCase()
        : '?';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
      child: Column(
        children: [
          BlocBuilder<ProfileImageBloc, ProfileImageState>(
            builder: (context, imgState) {
              final loaded = imgState is ProfileImageLoaded ? imgState : null;
              final hasImage = loaded?.bytes != null;
              final isUploading = imgState is ProfileImageUploading;
              final isDeleting = imgState is ProfileImageDeleting;

              return ProfileHeaderCard(
                user: profile.user,
                avatarWidget: ProfileAvatarWidget(
                  imageBytes: loaded?.bytes,
                  hasImage: hasImage,
                  isLoading: isUploading,
                  isDeleting: isDeleting,
                  initials: initials,
                ),
              );
            },
          ),
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
          const _SecuritySettingsSection(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () =>
                  context.read<AuthBloc>().add(const LogoutSubmitted()),
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
          ),
        ],
      ),
    );
  }
}

class _SecuritySettingsSection extends StatefulWidget {
  const _SecuritySettingsSection();

  @override
  State<_SecuritySettingsSection> createState() =>
      _SecuritySettingsSectionState();
}

class _SecuritySettingsSectionState extends State<_SecuritySettingsSection> {
  bool _isExpanded = false;
  bool _biometricEnabled = false;
  bool _canUseBiometrics = false;
  bool _biometricUpdating = false;

  @override
  void initState() {
    super.initState();
    _loadBiometricState();
  }

  Future<void> _loadBiometricState() async {
    try {
      final preferences = context.read<BiometricPreferencesService>();
      final biometricService = context.read<BiometricAuthService>();
      final enabled = await preferences.isBiometricEnabled();
      final canUse = await biometricService.isDeviceSupported() &&
          await biometricService.canCheckBiometrics() &&
          await biometricService.hasAvailableBiometrics();
      if (!mounted) return;
      setState(() {
        _biometricEnabled = enabled && canUse;
        _canUseBiometrics = canUse;
      });
      if (enabled && !canUse) {
        await preferences.setBiometricEnabled(false);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _biometricEnabled = false;
        _canUseBiometrics = false;
      });
    }
  }

  Future<void> _toggleBiometric(bool enabled) async {
    final loc = AppLocalizations.of(context)!;
    final preferences = context.read<BiometricPreferencesService>();
    if (!enabled) {
      await preferences.setBiometricEnabled(false);
      if (!mounted) return;
      setState(() => _biometricEnabled = false);
      _showSnackBar(loc.biometricDisabledSuccess);
      return;
    }

    setState(() => _biometricUpdating = true);
    try {
      final biometricService = context.read<BiometricAuthService>();
      final canUse = await biometricService.isDeviceSupported() &&
          await biometricService.canCheckBiometrics() &&
          await biometricService.hasAvailableBiometrics();
      if (!canUse) {
        await preferences.setBiometricEnabled(false);
        if (!mounted) return;
        setState(() {
          _biometricEnabled = false;
          _canUseBiometrics = false;
        });
        _showSnackBar(loc.biometricUnavailable, isError: true);
        return;
      }

      final authenticated = await biometricService.authenticate(
        localizedReason: loc.biometricEnableReason,
      );
      if (!authenticated) return;

      await preferences.setBiometricEnabled(true);
      await preferences.setFirstBiometricSetupDone(true);
      if (!mounted) return;
      setState(() {
        _biometricEnabled = true;
        _canUseBiometrics = true;
      });
      _showSnackBar(loc.biometricEnabledSuccess);
    } on BiometricAuthException catch (e) {
      if (mounted) {
        _showSnackBar(_biometricErrorMessage(loc, e), isError: true);
      }
    } catch (_) {
      if (mounted) {
        _showSnackBar(loc.biometricEnableFailed, isError: true);
      }
    } finally {
      if (mounted) setState(() => _biometricUpdating = false);
    }
  }

  String _biometricErrorMessage(
    AppLocalizations loc,
    BiometricAuthException exception,
  ) {
    switch (exception.failure) {
      case BiometricAuthFailure.notAvailable:
      case BiometricAuthFailure.uiUnavailable:
        return loc.biometricAuthenticationNotAvailable;
      case BiometricAuthFailure.notEnrolled:
        return loc.biometricConfigureInSettings;
      case BiometricAuthFailure.lockedOut:
      case BiometricAuthFailure.canceled:
      case BiometricAuthFailure.unknown:
        return loc.biometricAuthFailed;
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    final cs = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? cs.error : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(16),
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
                          loc.securitySettings,
                          style: tt.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: cs.onSurface,
                          ),
                        ),
                        Text(
                          loc.profileSecuritySubtitle,
                          style: tt.bodySmall?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child:
                        Icon(Icons.expand_more, color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: [
                Divider(height: 1, thickness: 1, color: cs.outlineVariant),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Icon(Icons.fingerprint, size: 20, color: cs.primary),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(loc.biometrics,
                                style: tt.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: cs.onSurface)),
                            Text(
                              _canUseBiometrics
                                  ? loc.biometricUnlockSubtitleAvailable
                                  : loc.biometricUnlockSubtitleUnavailable,
                              style: tt.bodySmall
                                  ?.copyWith(color: cs.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                      _biometricUpdating
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Switch(
                              value: _biometricEnabled,
                              onChanged: (_canUseBiometrics && !_biometricUpdating)
                                  ? (v) => _toggleBiometric(v)
                                  : null,
                            ),
                    ],
                  ),
                ),
                Divider(height: 1, thickness: 1, color: cs.outlineVariant),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 20, color: cs.primary),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(loc.autoLock,
                            style: tt.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: cs.onSurface)),
                      ),
                      Text('5 min',
                          style: tt.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: cs.primary)),
                    ],
                  ),
                ),
                Divider(height: 1, thickness: 1, color: cs.outlineVariant),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Icon(Icons.dark_mode_outlined, size: 20, color: cs.primary),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(loc.themeDark,
                            style: tt.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: cs.onSurface)),
                      ),
                      ValueListenableBuilder<ThemeMode>(
                        valueListenable: themeNotifier,
                        builder: (context, mode, _) {
                          return Switch(
                            value: mode == ThemeMode.dark,
                            onChanged: (enabled) => setAppThemeMode(
                              enabled ? ThemeMode.dark : ThemeMode.light,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, thickness: 1, color: cs.outlineVariant),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loc.activeSessions)),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 20, color: cs.error),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(loc.activeSessions,
                              style: tt.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: cs.onSurface)),
                        ),
                        Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
                      ],
                    ),
                  ),
                ),
                Divider(height: 1, thickness: 1, color: cs.outlineVariant),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loc.deactivateAccount)),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Icon(Icons.person_remove_outlined,
                            size: 20, color: cs.error),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(loc.deactivateAccount,
                              style: tt.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: cs.onSurface)),
                        ),
                        Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
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
    final loc = AppLocalizations.of(context)!;

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
              label: Text(loc.retry),
            ),
          ],
        ),
      ),
    );
  }
}
