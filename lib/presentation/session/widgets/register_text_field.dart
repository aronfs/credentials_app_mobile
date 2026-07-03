import 'package:flutter/material.dart';

/// Campo de texto con label encima y borde rectangular redondeado
/// completo. Soporta icono prefijo, modo contraseña con toggle de
/// visibilidad, y callback de cambio.
class RegisterTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const RegisterTextField({
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
  State<RegisterTextField> createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField> {
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E2EA), width: 1.2),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Icon(
                  widget.prefixIcon,
                  size: 17,
                  color: const Color(0xFFB7BAC6),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.isPassword && _obscure,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1A1A2E),
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      color: Color(0xFFB7BAC6),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 13,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              if (widget.isPassword)
                GestureDetector(
                  onTap: () => setState(() => _obscure = !_obscure),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: Icon(
                      _obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 18,
                      color: const Color(0xFFB7BAC6),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
