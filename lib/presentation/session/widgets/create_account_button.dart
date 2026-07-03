import 'package:flutter/material.dart';

/// Botón primario de registro "Crear cuenta →": fondo azul-violeta
/// sólido, texto blanco con icono de flecha.
class CreateAccountButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color color;

  const CreateAccountButton({
    super.key,
    this.label = 'Crear cuenta',
    this.isLoading = false,
    this.color = const Color(0xFF5C6BC0),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: isLoading ? null : onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : Row(
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
                    const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                  ],
                ),
        ),
      ),
    );
  }
}

/// Link "Ya tengo cuenta >" debajo del botón principal.
class AlreadyHaveAccountLink extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;

  const AlreadyHaveAccountLink({
    super.key,
    this.onTap,
    this.label = 'Ya tengo cuenta >',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5C6BC0),
        ),
      ),
    );
  }
}
