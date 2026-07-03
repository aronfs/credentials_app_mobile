import 'package:archive_secure/data/auth/bloc/auth_bloc.dart';
import 'package:archive_secure/data/auth/bloc/auth_event.dart';
import 'package:archive_secure/data/auth/bloc/auth_state.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/navigation/route.dart';
import 'package:archive_secure/presentation/screens/widgets/face_id_link.dart';
import 'package:archive_secure/presentation/screens/widgets/pin_dots_indicator.dart';
import 'package:archive_secure/presentation/screens/widgets/pin_keypad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinEntryPage extends StatefulWidget {
  final int pinLength;
  final String title;
  final String subtitle;
  final VoidCallback? onBiometric;
  final VoidCallback? onFaceId;
  final VoidCallback? onVerified;

  const PinEntryPage({
    super.key,
    this.pinLength = 4,
    this.title = '',
    this.subtitle = '',
    this.onBiometric,
    this.onFaceId,
    this.onVerified,
  });

  @override
  State<PinEntryPage> createState() => _PinEntryPageState();
}

class _PinEntryPageState extends State<PinEntryPage> {
  String _pin = '';

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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final displayTitle =
        widget.title.isNotEmpty ? widget.title : loc.pinEntryTitle;
    final displaySubtitle =
        widget.subtitle.isNotEmpty ? widget.subtitle : loc.pinEntrySubtitle;
    return Scaffold(
      backgroundColor: const Color(0xFF141628),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PinVerified) {
            if (widget.onVerified != null) {
              widget.onVerified!();
              Navigator.pop(context, true);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                homePage,
                (route) => false,
              );
            }
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
                  onBiometric: widget.onBiometric,
                ),
                const Spacer(),
                FaceIdLink(
                  label: loc.useFaceId,
                  onTap: widget.onFaceId,
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
