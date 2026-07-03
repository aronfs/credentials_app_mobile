import 'package:flutter/material.dart';
import 'pin_key.dart';

/// Teclado numérico circular de 3×4 para entrada de PIN:
/// dígitos 1-9, luego [biometría | 0 | ⌫].
///
/// Callbacks:
/// - [onDigit] — dígito presionado ("0"-"9").
/// - [onDelete] — tecla de borrar presionada.
/// - [onBiometric] — tecla de huella/biometría presionada.
class PinKeypad extends StatelessWidget {
  final ValueChanged<String> onDigit;
  final VoidCallback? onDelete;
  final VoidCallback? onBiometric;
  final double keySize;
  final double spacing;

  const PinKeypad({
    super.key,
    required this.onDigit,
    this.onDelete,
    this.onBiometric,
    this.keySize = 72,
    this.spacing = 18,
  });

  @override
  Widget build(BuildContext context) {
    final rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Filas 1-9
        ...rows.map(
          (row) => Padding(
            padding: EdgeInsets.only(bottom: spacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: row.map((digit) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: spacing / 2),
                  child: PinKey(
                    digit: digit,
                    size: keySize,
                    onTap: () => onDigit(digit),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        // Última fila: biometría | 0 | borrar
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing / 2),
              child: PinKey(
                icon: Icons.fingerprint,
                size: keySize,
                foregroundColor: const Color(0xFF8A8FA8),
                onTap: onBiometric,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing / 2),
              child: PinKey(
                digit: '0',
                size: keySize,
                onTap: () => onDigit('0'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing / 2),
              child: PinKey(
                icon: Icons.backspace_outlined,
                size: keySize,
                foregroundColor: const Color(0xFF8A8FA8),
                backgroundColor: Colors.transparent,
                onTap: onDelete,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
