import 'dart:async';

import 'package:archive_secure/core/services/advanced_biometric_auth_service.dart';
import 'package:archive_secure/core/services/app_lock_service.dart';
import 'package:archive_secure/core/services/face_auth_preferences_service.dart';
import 'package:archive_secure/data/auth/bloc/auth_bloc.dart';
import 'package:archive_secure/data/auth/bloc/auth_event.dart';
import 'package:archive_secure/data/auth/bloc/auth_state.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/navigation/route.dart';
import 'package:archive_secure/presentation/auth/pages/face_setup_page.dart';
import 'package:archive_secure/presentation/screens/widgets/face_id_link.dart';
import 'package:archive_secure/presentation/screens/widgets/pin_dots_indicator.dart';
import 'package:archive_secure/presentation/screens/widgets/pin_keypad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PinEntryPurpose { unlockApp, revealCredentialPassword }

class PinEntryPage extends StatefulWidget {
  final int pinLength;
  final String title;
  final String subtitle;
  final PinEntryPurpose purpose;
  final String? credentialId;
  final VoidCallback? onBiometric;
  final VoidCallback? onFaceId;
  final VoidCallback? onVerified;

  const PinEntryPage({
    super.key,
    this.pinLength = 4,
    this.title = '',
    this.subtitle = '',
    this.purpose = PinEntryPurpose.unlockApp,
    this.credentialId,
    this.onBiometric,
    this.onFaceId,
    this.onVerified,
  });

  @override
  State<PinEntryPage> createState() => _PinEntryPageState();
}

class _PinEntryPageState extends State<PinEntryPage> {
  final _advancedBiometricService = AdvancedBiometricAuthService();
  final _facePreferences = FaceAuthPreferencesService();

  String _pin = '';
  bool _isAuthenticatingBiometric = false;
  bool _advancedBiometricsAvailable = false;
  bool _isLoadingBiometricAvailability = true;
  bool _isShowingFaceSetup = false;
  bool _hasPromptedFaceSetup = false;

  @override
  void initState() {
    super.initState();
    _loadAdvancedBiometricState();
  }

  Future<void> _loadAdvancedBiometricState() async {
    try {
      final setupDone = await _facePreferences.isFirstFaceSetupDone();
      final available = await _advancedBiometricService
          .canUseAdvancedBiometrics();
      if (!mounted) return;
      setState(() {
        _advancedBiometricsAvailable = available;
        _isLoadingBiometricAvailability = false;
      });

      if (!setupDone && !_hasPromptedFaceSetup) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showInitialAdvancedBiometricSetup();
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _advancedBiometricsAvailable = false;
        _isLoadingBiometricAvailability = false;
      });
    }
  }

  Future<void> _showInitialAdvancedBiometricSetup() async {
    if (!mounted || _isShowingFaceSetup || widget.onVerified != null) return;
    _isShowingFaceSetup = true;
    _hasPromptedFaceSetup = true;
    await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const FaceSetupPage(),
      ),
    );
    _isShowingFaceSetup = false;
    await _loadAdvancedBiometricState();
  }

  void _onDigit(BuildContext context, String digit) {
    if (_pin.length >= widget.pinLength) return;
    setState(() => _pin += digit);
    if (_pin.length == widget.pinLength) {
      final bloc = context.read<AuthBloc>();
      final pin = _pin;
      Future.delayed(const Duration(milliseconds: 120), () {
        bloc.add(VerifyPinSubmitted(pin: pin));
      });
    }
  }

  void _onDelete() {
    if (_pin.isEmpty) return;
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  Future<void> _unlockSuccess() async {
    if (!mounted) return;

    await AppLockService.instance.setUnlocked(true);

    if (!mounted) return;

    switch (widget.purpose) {
      case PinEntryPurpose.unlockApp:
        if (widget.onVerified != null) {
          widget.onVerified!();
          Navigator.of(context).pop(true);
          return;
        }
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(homePage, (route) => false);
        return;
      case PinEntryPurpose.revealCredentialPassword:
        widget.onVerified?.call();
        Navigator.of(context).pop(true);
        return;
    }
  }

  Future<void> _onAdvancedBiometricPressed() async {
    if (_isAuthenticatingBiometric) return;

    setState(() => _isAuthenticatingBiometric = true);
    var success = false;
    AppLockService.instance.beginBiometricUnlock();

    try {
      final loc = AppLocalizations.of(context)!;
      success = await _advancedBiometricService.authenticate();
      if (!mounted) return;

      if (success) {
        await _unlockSuccess();
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.biometricAuthFailed),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.biometricAuthFailed),
          backgroundColor: Colors.red.shade700,
        ),
      );
    } finally {
      if (AppLockService.instance.isBiometricUnlockInProgress) {
        AppLockService.instance.finishBiometricUnlock(success: success);
      }
      if (mounted && ModalRoute.of(context)?.isCurrent == true) {
        setState(() => _isAuthenticatingBiometric = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final displayTitle = widget.title.isNotEmpty
        ? widget.title
        : loc.pinEntryTitle;
    final displaySubtitle = widget.subtitle.isNotEmpty
        ? widget.subtitle
        : loc.pinEntrySubtitle;
    final shouldShowAdvancedBiometrics =
        !_isLoadingBiometricAvailability && _advancedBiometricsAvailable;
    return Scaffold(
      backgroundColor: const Color(0xFF141628),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PinVerified) {
            unawaited(_unlockSuccess());
            return;
          }
          if (state is PinVerificationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red.shade700,
              ),
            );
            setState(() => _pin = '');
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFF252844),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF3A3D5C),
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: state is AuthLoading
                      ? const SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.lock_outline,
                          size: 28,
                          color: Colors.white,
                        ),
                ),
                const SizedBox(height: 22),
                Text(
                  displayTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  displaySubtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7090),
                  ),
                ),
                const SizedBox(height: 36),
                PinDotsIndicator(
                  totalDigits: widget.pinLength,
                  filledCount: _pin.length,
                ),
                const Spacer(),
                PinKeypad(
                  onDigit: (digit) => _onDigit(context, digit),
                  onDelete: _onDelete,
                  showBiometric: false,
                ),
                const Spacer(),
                if (shouldShowAdvancedBiometrics)
                  FaceIdLink(
                    label: loc.useFaceId,
                    onTap: _isAuthenticatingBiometric
                        ? null
                        : _onAdvancedBiometricPressed,
                  ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
