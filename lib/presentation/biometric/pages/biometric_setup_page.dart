import 'package:archive_secure/core/services/biometric_auth_service.dart';
import 'package:archive_secure/core/services/biometric_preferences_service.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/navigation/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricSetupPage extends StatefulWidget {
  const BiometricSetupPage({super.key});

  @override
  State<BiometricSetupPage> createState() => _BiometricSetupPageState();
}

class _BiometricSetupPageState extends State<BiometricSetupPage> {
  bool _isAuthenticating = false;

  Future<void> _activateBiometric() async {
    if (_isAuthenticating) return;
    setState(() => _isAuthenticating = true);

    final loc = AppLocalizations.of(context)!;
    final authService = context.read<BiometricAuthService>();
    final preferences = context.read<BiometricPreferencesService>();

    try {
      final isSupported = await authService.isDeviceSupported();
      if (!mounted) return;
      if (!isSupported) {
        _showError(loc.biometricAuthenticationNotAvailable);
        return;
      }

      final canCheckBiometrics = await authService.canCheckBiometrics();
      final hasAvailableBiometrics =
          canCheckBiometrics && await authService.hasAvailableBiometrics();
      if (!mounted) return;
      if (!hasAvailableBiometrics) {
        _showError(loc.biometricConfigureInSettings);
        return;
      }

      final authenticated = await authService.authenticate(
        localizedReason: loc.biometricEnableReason,
      );
      if (!mounted) return;
      if (!authenticated) {
        _showError(loc.biometricEnableFailed);
        return;
      }

      await preferences.setBiometricEnabled(true);
      await preferences.setFirstBiometricSetupDone(true);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.biometricAccessEnabledSuccessfully)),
      );
      _continueToPin();
    } on BiometricAuthException catch (e) {
      if (mounted) _showError(_messageForFailure(loc, e.failure));
    } catch (_) {
      if (mounted) _showError(loc.biometricAuthFailed);
    } finally {
      if (mounted) setState(() => _isAuthenticating = false);
    }
  }

  Future<void> _skipForNow() async {
    if (_isAuthenticating) return;
    final preferences = context.read<BiometricPreferencesService>();
    await preferences.setBiometricEnabled(false);
    await preferences.setFirstBiometricSetupDone(true);
    if (!mounted) return;
    _continueToPin();
  }

  void _continueToPin() {
    Navigator.pushNamedAndRemoveUntil(context, pinEntryPage, (route) => false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  String _messageForFailure(
    AppLocalizations loc,
    BiometricAuthFailure failure,
  ) {
    switch (failure) {
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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      body: SafeArea(
        child: Stack(
          children: [
            const _DottedBackground(),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .24),
                          blurRadius: 32,
                          offset: const Offset(0, 18),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 76,
                          height: 76,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEFF6FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.fingerprint_rounded,
                            color: Color(0xFF3B82F6),
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          loc.biometricSetupTitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: const Color(0xFF0F172A),
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          loc.biometricSetupDescription,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: const Color(0xFF475569),
                                height: 1.45,
                              ),
                        ),
                        const SizedBox(height: 28),
                        FilledButton.icon(
                          onPressed: _isAuthenticating
                              ? null
                              : _activateBiometric,
                          icon: _isAuthenticating
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.fingerprint_rounded),
                          label: Text(loc.biometricSetupActivate),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: _isAuthenticating ? null : _skipForNow,
                          child: Text(loc.biometricSetupSkip),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DottedBackground extends StatelessWidget {
  const _DottedBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBackgroundPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _DottedBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: .08)
      ..style = PaintingStyle.fill;

    const step = 22.0;
    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 1.1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
