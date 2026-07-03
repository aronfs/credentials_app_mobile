import 'package:archive_secure/core/security/biometric_service.dart';
import 'package:archive_secure/core/security/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  final _biometricService = BiometricService();
  bool _biometricEnabled = false;
  bool _isLoading = true;
  bool _canUseBiometrics = false;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final tokenStorage = context.read<TokenStorage>();
    final enabled = await tokenStorage.getBiometricEnabled();
    final canUse =
        await _biometricService.isAvailable() &&
        await _biometricService.hasEnrolledBiometrics();
    if (mounted) {
      setState(() {
        _biometricEnabled = enabled;
        _canUseBiometrics = canUse;
        _isLoading = false;
      });
    }
  }

  Future<void> _toggle(bool value) async {
    if (value) {
      await _enableBiometric();
    } else {
      await _disableBiometric();
    }
  }

  Future<void> _enableBiometric() async {
    setState(() => _isLoading = true);
    final tokenStorage = context.read<TokenStorage>();
    try {
      final available = await _biometricService.isAvailable();
      if (!available) {
        _showMessage('Este dispositivo no soporta autenticación biométrica.');
        setState(() => _isLoading = false);
        return;
      }

      final enrolled = await _biometricService.hasEnrolledBiometrics();
      if (!enrolled) {
        _showMessage(
          'No tienes huellas o Face ID configurados en el dispositivo.',
        );
        setState(() => _isLoading = false);
        return;
      }

      final authenticated = await _biometricService.authenticate(
        reason: 'Activar inicio de sesión con huella',
      );
      if (!authenticated) {
        setState(() => _isLoading = false);
        return;
      }

      await tokenStorage.saveBiometricEnabled(true);
      if (mounted) {
        setState(() {
          _biometricEnabled = true;
          _isLoading = false;
        });
        _showMessage('Inicio con huella activado correctamente.');
      }
    } on BiometricException catch (e) {
      if (mounted) {
        _showMessage(e.message);
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        _showMessage('No se pudo completar la operación.');
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _disableBiometric() async {
    final tokenStorage = context.read<TokenStorage>();
    await tokenStorage.saveBiometricEnabled(false);
    if (mounted) {
      setState(() => _biometricEnabled = false);
      _showMessage('Inicio con huella desactivado.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        title: Text(
          'Seguridad',
          style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: cs.outlineVariant),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: cs.secondaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.fingerprint,
                              color: cs.onSecondaryContainer,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Inicio con huella',
                                  style: tt.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _canUseBiometrics
                                      ? 'Accede con tu huella o Face ID'
                                      : 'Biometría no disponible en este dispositivo',
                                  style: tt.bodySmall?.copyWith(
                                    color: cs.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _biometricEnabled,
                            onChanged: _canUseBiometrics ? _toggle : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
