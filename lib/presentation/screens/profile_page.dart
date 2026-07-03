import 'package:archive_secure/core/security/biometric_service.dart';
import 'package:archive_secure/core/security/token_storage.dart';
import 'package:archive_secure/core/theme/theme_mode_controller.dart';
import 'package:archive_secure/data/profile/bloc/profile_cubit.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/presentation/screens/widgets/logout_button.dart';
import 'package:archive_secure/presentation/screens/widgets/profile_header.dart';
import 'package:archive_secure/presentation/screens/widgets/settings_section_card.dart';
import 'package:archive_secure/presentation/screens/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _biometricEnabled = false;
  bool _biometricUpdating = false;
  bool _canUseBiometrics = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().load();
    _loadBiometricState();
  }

  Future<void> _loadBiometricState() async {
    try {
      final tokenStorage = context.read<TokenStorage>();
      final biometricService = context.read<BiometricService>();
      final enabled = await tokenStorage.getBiometricEnabled();
      final canUse = await biometricService.canUseBiometrics();
      if (!mounted) return;
      setState(() {
        _biometricEnabled = enabled && canUse;
        _canUseBiometrics = canUse;
      });
      if (enabled && !canUse) {
        await tokenStorage.saveBiometricEnabled(false);
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
    final tokenStorage = context.read<TokenStorage>();
    if (!enabled) {
      await tokenStorage.saveBiometricEnabled(false);
      if (!mounted) return;
      setState(() => _biometricEnabled = false);
      _showSnackBar(loc.biometricDisabledSuccess);
      return;
    }

    setState(() => _biometricUpdating = true);
    try {
      final biometricService = context.read<BiometricService>();
      final canUse = await biometricService.canUseBiometrics();
      if (!canUse) {
        await tokenStorage.saveBiometricEnabled(false);
        if (!mounted) return;
        setState(() {
          _biometricEnabled = false;
          _canUseBiometrics = false;
        });
        _showSnackBar(loc.biometricUnavailable, isError: true);
        return;
      }

      final authenticated = await biometricService.authenticate(
        reason: loc.biometricEnableReason,
      );
      if (!authenticated) return;

      await tokenStorage.saveBiometricEnabled(true);
      if (!mounted) return;
      setState(() {
        _biometricEnabled = true;
        _canUseBiometrics = true;
      });
      _showSnackBar(loc.biometricEnabledSuccess);
    } on BiometricException catch (e) {
      if (mounted) _showSnackBar(e.message, isError: true);
    } catch (_) {
      if (mounted) _showSnackBar(loc.biometricEnableFailed, isError: true);
    } finally {
      if (mounted) setState(() => _biometricUpdating = false);
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

  void _showChangePasswordDialog() {
    final currentCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cambiar contraseña'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña actual'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Nueva contraseña'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar nueva contraseña',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              if (newCtrl.text != confirmCtrl.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Las contraseñas no coinciden')),
                );
                return;
              }
              context.read<ProfileCubit>().changePassword(
                currentCtrl.text,
                newCtrl.text,
              );
              Navigator.pop(ctx);
            },
            child: const Text('Cambiar'),
          ),
        ],
      ),
    );
  }

  void _showChangePinDialog() {
    final currentCtrl = TextEditingController();
    final newCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cambiar PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentCtrl,
              obscureText: true,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'PIN actual'),
            ),
            TextField(
              controller: newCtrl,
              obscureText: true,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nuevo PIN (4-6 dígitos)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              context.read<ProfileCubit>().changePin(
                currentCtrl.text,
                newCtrl.text,
              );
              Navigator.pop(ctx);
            },
            child: const Text('Cambiar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: cs.surface,
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.updated &&
              state.successMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.successMessage!)));
          }
          if (state.status == ProfileStatus.error && state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!), backgroundColor: cs.error),
            );
          }
        },
        builder: (context, state) {
          final user = state.data?.user;
          final stats = state.data?.stats;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
              child: Column(
                children: [
                  ProfileHeader(
                    name: user?.name ?? 'Cargando...',
                    email: user?.email ?? '',
                  ),
                  if (stats != null) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatBadge(
                          icon: Icons.lock_outline,
                          value: '${stats.totalCredentials}',
                          label: 'Credenciales',
                        ),
                        _StatBadge(
                          icon: Icons.folder_outlined,
                          value: '${stats.totalCategories}',
                          label: 'Categorías',
                        ),
                        _StatBadge(
                          icon: Icons.star_outline,
                          value: '${stats.totalFavorites}',
                          label: 'Favoritos',
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 24),
                  SettingsSectionCard(
                    title: 'SEGURIDAD',
                    children: [
                      SettingsTile(
                        icon: Icons.password,
                        title: 'Cambiar contraseña',
                        onTap: _showChangePasswordDialog,
                      ),
                      SettingsTile(
                        icon: Icons.pin_outlined,
                        title: 'Cambiar PIN',
                        onTap: _showChangePinDialog,
                      ),
                      SettingsTile(
                        icon: Icons.fingerprint,
                        title: loc.biometricUnlockTitle,
                        subtitle: _canUseBiometrics
                            ? loc.biometricUnlockSubtitleAvailable
                            : loc.biometricUnlockSubtitleUnavailable,
                        trailing: Switch(
                          value: _biometricEnabled,
                          onChanged: _biometricUpdating
                              ? null
                              : (value) => _toggleBiometric(value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  SettingsSectionCard(
                    title: 'PREFERENCIAS',
                    children: [
                      SettingsTile(
                        icon: Icons.timer_outlined,
                        title: 'Bloqueo automático',
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '5 min',
                              style: TextStyle(
                                color: cs.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: () {},
                      ),
                      SettingsTile(
                        icon: Icons.dark_mode_outlined,
                        title: 'Modo oscuro',
                        trailing: ValueListenableBuilder<ThemeMode>(
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  const LogoutButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatBadge({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Icon(icon, color: cs.primary, size: 22),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: cs.onSurface,
          ),
        ),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
        ),
      ],
    );
  }
}
