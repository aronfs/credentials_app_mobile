import 'package:flutter/material.dart';

/// Botón "Comenzar ✓" de ancho completo: fondo azul-violeta sólido,
/// texto blanco con ícono de check a la derecha.
class StartButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;

  const StartButton({
    super.key,
    this.label = 'Comenzar',
    this.color = const Color(0xFF3D3DBF),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.check, size: 18, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
