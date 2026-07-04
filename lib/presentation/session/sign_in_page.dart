import 'dart:async';

import 'package:archive_secure/core/security/biometric_service.dart';
import 'package:archive_secure/core/security/token_storage.dart';
import 'package:archive_secure/data/auth/bloc/auth_bloc.dart';
import 'package:archive_secure/data/auth/bloc/auth_event.dart';
import 'package:archive_secure/data/auth/bloc/auth_state.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/navigation/route.dart';
import 'package:archive_secure/presentation/session/constants/widget_constants.dart';
import 'package:archive_secure/presentation/session/widgets/account_links_group.dart';
import 'package:archive_secure/presentation/session/widgets/app_logo_header.dart';
import 'package:archive_secure/presentation/session/widgets/biometric_button.dart';
import 'package:archive_secure/presentation/session/widgets/divider_with_label.dart';
import 'package:archive_secure/presentation/session/widgets/login_submit_button.dart';
import 'package:archive_secure/presentation/session/widgets/login_text_field.dart';
import 'package:archive_secure/presentation/session/widgets/security_footer.dart';
import 'package:archive_secure/ui.theme/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _biometricService = BiometricService();

  bool _canUseBiometrics = false;
  bool _hasRefreshToken = false;
  bool _isHandlingLoginSuccess = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      final tokenStorage = context.read<TokenStorage>();
      final refreshToken = await tokenStorage.getRefreshToken();
      final biometricEnabled = await tokenStorage.getBiometricEnabled();
      final canUse = await _biometricService.canUseBiometrics();

      if (mounted) {
        setState(() {
          _canUseBiometrics = canUse && biometricEnabled;
          _hasRefreshToken = refreshToken != null && refreshToken.isNotEmpty;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _canUseBiometrics = false;
          _hasRefreshToken = false;
        });
      }
    }
  }

  void _onLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) return;
    context.read<AuthBloc>().add(
      LoginSubmitted(email: email, password: password),
    );
  }

  void _onBiometric() {
    final loc = AppLocalizations.of(context)!;
    context.read<AuthBloc>().add(
      BiometricLoginRequested(reason: loc.biometricLoginReason),
    );
  }

  Future<void> _handlePasswordLoginSuccess() async {
    if (_isHandlingLoginSuccess) return;
    _isHandlingLoginSuccess = true;
    try {
      await _maybePromptEnableBiometric();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        pinEntryPage,
        (route) => false,
      );
    } finally {
      _isHandlingLoginSuccess = false;
    }
  }

  Future<void> _maybePromptEnableBiometric() async {
    final loc = AppLocalizations.of(context)!;
    final tokenStorage = context.read<TokenStorage>();
    final biometricEnabled = await tokenStorage.getBiometricEnabled();
    if (biometricEnabled) return;

    final canUseBiometrics = await _biometricService.canUseBiometrics();
    if (!canUseBiometrics || !mounted) return;

    final shouldEnable = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(loc.biometricEnableDialogTitle),
        content: Text(loc.biometricEnableDialogMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(loc.biometricEnableDialogNotNow),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(loc.biometricEnableDialogActivate),
          ),
        ],
      ),
    );

    if (shouldEnable == true) {
      await _activateBiometric();
    }
  }

  Future<void> _activateBiometric() async {
    final loc = AppLocalizations.of(context)!;
    final tokenStorage = context.read<TokenStorage>();
    try {
      final available = await _biometricService.isAvailable();
      if (!available) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(loc.biometricUnavailable),
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
        return;
      }

      final enrolled = await _biometricService.hasEnrolledBiometrics();
      if (!enrolled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(loc.biometricNotEnrolled),
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
        return;
      }

      final authenticated = await _biometricService.authenticate(
        reason: loc.biometricEnableReason,
      );
      if (!authenticated) return;

      await tokenStorage.saveBiometricEnabled(true);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.biometricEnabledSuccess),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } on BiometricException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_locBiometricError(loc, e.type)),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.biometricEnableFailed),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  String _locBiometricError(AppLocalizations loc, BiometricErrorType type) {
    switch (type) {
      case BiometricErrorType.notAvailable:
        return loc.biometricDeviceNotSupported;
      case BiometricErrorType.notEnrolled:
        return loc.biometricNotEnrolledMessage;
      case BiometricErrorType.lockedOut:
        return loc.biometricTooManyAttempts;
      case BiometricErrorType.permanentlyLockedOut:
        return loc.biometricBlocked;
      case BiometricErrorType.userCancel:
        return loc.biometricCancelled;
      case BiometricErrorType.unknown:
        return loc.biometricAuthFailedMessage;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Theme(
      data: AppTheme.themeForms,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          unawaited(_handlePasswordLoginSuccess());
                          return;
                        }
                        if (state is SessionRefreshed) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            pinEntryPage,
                            (route) => false,
                          );
                        }
                        if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              backgroundColor: Colors.red.shade700,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;
                        return SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppLogoHeader(
                                icon: Icons.lock,
                                iconColor: const Color(0xFF5C6BC0),
                                appName: loc.titleSignIn,
                                subtitle: loc.descriptionSignIn,
                              ),
                              const SizedBox(height: 28),
                              LoginTextField(
                                label: loc.labelSignIn,
                                hintText: loc.hintSignIn,
                                prefixIcon: Icons.mail_outline,
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                              ),
                              const SizedBox(height: 20),
                              LoginTextField(
                                label: loc.labelPassword,
                                hintText: hintPasword,
                                prefixIcon: Icons.vpn_key_outlined,
                                isPassword: true,
                                controller: passwordController,
                              ),
                              const SizedBox(height: 20),
                              LoginSubmitButton(
                                onPressed: isLoading ? null : () => _onLogin(),
                                label: loc.btnSignIn,
                                isLoading: isLoading,
                              ),
                              if (_canUseBiometrics && _hasRefreshToken) ...[
                                const SizedBox(height: 8),
                                DividerWithLabel(label: loc.divider),
                                const SizedBox(height: 8),
                                BiometricButton(
                                  onPressed: isLoading ? null : _onBiometric,
                                  label: loc.btnBiometry,
                                ),
                              ],
                              const SizedBox(height: 16),
                              AccountLinksGroup(
                                onCreateAccount: () =>
                                    Navigator.pushNamed(context, signUpPage),
                                onForgotPassword: () {},
                                lblCreateAccount: loc.textSignIn,
                                lblForgotPassword: loc.textPasword,
                              ),
                              const SizedBox(height: 20),
                              const Divider(
                                color: Color(0xFFEEF0F4),
                                thickness: 1,
                              ),
                              const SizedBox(height: 12),
                              SecurityFooter(label: loc.footerSignIn),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
