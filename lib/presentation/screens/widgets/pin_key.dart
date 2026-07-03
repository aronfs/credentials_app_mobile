import 'package:flutter/material.dart';

/// Tecla circular del teclado numérico de PIN.
/// Puede contener: un dígito, un icono (biometría, borrar) o
/// estar vacía/invisible.
class PinKey extends StatelessWidget {
  final String? digit;
  final IconData? icon;
  final bool isVisible;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final double size;

  const PinKey({
    super.key,
    this.digit,
    this.icon,
    this.isVisible = true,
    this.onTap,
    this.backgroundColor = const Color(0xFF252844),
    this.foregroundColor = Colors.white,
    this.size = 72,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return SizedBox(width: size, height: size);

    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        splashColor: Colors.white.withValues(alpha: 0.1),
        highlightColor: Colors.white.withValues(alpha: 0.05),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: digit != null
                ? Text(
                    digit!,
                    style: TextStyle(
                      fontSize: size * 0.33,
                      fontWeight: FontWeight.w500,
                      color: foregroundColor,
                    ),
                  )
                : icon != null
                    ? Icon(icon, size: size * 0.36, color: foregroundColor)
                    : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
