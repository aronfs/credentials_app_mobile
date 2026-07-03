import 'package:archive_secure/presentation/session/widgets/password_strength_bar.dart';
import 'package:flutter/material.dart';


/// Card especial de campo de contraseña: header "CONTRASEÑA" con link
/// "Generar" a la derecha, input con icono llave + toggle visibilidad,
/// y barra de fortaleza integrada debajo. Fondo gris claro que agrupa
/// todo el bloque.
class PasswordFieldCard extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onGenerate;

  const PasswordFieldCard({
    super.key,
    this.controller,
    this.onChanged,
    this.onGenerate,
  });

  @override
  State<PasswordFieldCard> createState() => _PasswordFieldCardState();
}

class _PasswordFieldCardState extends State<PasswordFieldCard> {
  bool _obscure = true;
  PasswordStrength _strength = PasswordStrength.empty;

  void _handleChanged(String value) {
    setState(() {
      _strength = PasswordStrengthExt.evaluate(value);
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEEF0F4), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'CONTRASEÑA',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF9A9DB0),
                  letterSpacing: 0.4,
                ),
              ),
              GestureDetector(
                onTap: widget.onGenerate,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bolt, size: 14, color: Color(0xFF3D5AFE)),
                    SizedBox(width: 3),
                    Text(
                      'Generar',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3D5AFE),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E2EA), width: 1),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Icon(
                    Icons.vpn_key_outlined,
                    size: 16,
                    color: Color(0xFFB7BAC6),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    obscureText: _obscure,
                    onChanged: _handleChanged,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1A1A2E),
                      letterSpacing: 1,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _obscure = !_obscure),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(
                      _obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 17,
                      color: const Color(0xFFB7BAC6),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'FORTALEZA',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF9A9DB0),
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: PasswordStrengthBar(strength: _strength)),
            ],
          ),
        ],
      ),
    );
  }
}
