import 'package:flutter/material.dart';

/// Campo de texto de login: label pequeño encima, input con icono
/// prefijo, fondo blanco con borde inferior sutil. Soporta modo
/// contraseña con botón toggle de visibilidad.
class LoginTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const LoginTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B6E80),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFE0E2EA), width: 1),
            ),
          ),
          child: Row(
            children: [
              Icon(
                widget.prefixIcon,
                size: 18,
                color: const Color(0xFFB7BAC6),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.isPassword && _obscure,
                  style: const TextStyle(
                    fontSize: 14.5,
                    color: Color(0xFF1A1A2E),
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      color: Color(0xFFB7BAC6),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              if (widget.isPassword)
                GestureDetector(
                  onTap: () => setState(() => _obscure = !_obscure),
                  child: Icon(
                    _obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 18,
                    color: const Color(0xFFB7BAC6),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
