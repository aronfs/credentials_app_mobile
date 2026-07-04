import 'package:archive_secure/core/services/face_auth_preferences_service.dart';
import 'package:archive_secure/core/services/face_auth_service.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FaceSetupPage extends StatefulWidget {
  const FaceSetupPage({super.key});

  @override
  State<FaceSetupPage> createState() => _FaceSetupPageState();
}

class _FaceSetupPageState extends State<FaceSetupPage> {
  final _faceAuthService = FaceAuthService();
  final _preferences = FaceAuthPreferencesService();

  bool _isAuthenticating = false;

  Future<void> _activateFaceAuth() async {
    if (_isAuthenticating) return;
    setState(() => _isAuthenticating = true);

    final loc = AppLocalizations.of(context)!;
    try {
      final isFaceAvailable = await _faceAuthService.isFaceAvailable();
      if (!mounted) return;
      if (!isFaceAvailable) {
        _showError(loc.faceRecognitionNotAvailableOrConfigured);
        return;
      }

      final authenticated = await _faceAuthService.authenticateWithFace();
      if (!mounted) return;
      if (!authenticated) {
        _showError(loc.faceAuthenticationFailed);
        return;
      }

      await _preferences.setFaceAuthEnabled(true);
      await _preferences.setFirstFaceSetupDone(true);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.faceAuthenticationEnabledSuccessfully)),
      );
      Navigator.pop(context, true);
    } finally {
      if (mounted) setState(() => _isAuthenticating = false);
    }
  }

  Future<void> _skipForNow() async {
    if (_isAuthenticating) return;
    await _preferences.setFaceAuthEnabled(false);
    await _preferences.setFirstFaceSetupDone(true);
    if (!mounted) return;
    Navigator.pop(context, false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
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
                            Icons.face_retouching_natural_rounded,
                            color: Color(0xFF3B82F6),
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          loc.faceSetupTitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: const Color(0xFF0F172A),
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          loc.faceSetupDescription,
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
                              : _activateFaceAuth,
                          icon: _isAuthenticating
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(
                                  Icons.face_retouching_natural_rounded,
                                ),
                          label: Text(loc.faceSetupActivate),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: _isAuthenticating ? null : _skipForNow,
                          child: Text(loc.faceSetupSkip),
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
