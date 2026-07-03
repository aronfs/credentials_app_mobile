import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Entrada de PIN de seguridad: N cuadros separados, cada uno acepta
/// un solo dígito. Al completar uno avanza automáticamente al siguiente.
/// El PIN completo se expone mediante [onCompleted].
class PinInputField extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final String? label;
  final String? hint;

  const PinInputField({
    super.key,
    this.length = 4,
    this.onCompleted,
    this.onChanged,
    this.label,
    this.hint,
  });

  @override
  State<PinInputField> createState() => _PinInputFieldState();
}

class _PinInputFieldState extends State<PinInputField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(String value, int index) {
    if (value.length == 1 && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    final pin = _controllers.map((c) => c.text).join();
    widget.onChanged?.call(pin);
    if (pin.length == widget.length) {
      widget.onCompleted?.call(pin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B6E80),
            ),
          ),
          const SizedBox(height: 10),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                right: index < widget.length - 1 ? 12 : 0,
              ),
              child: SizedBox(
                width: 52,
                height: 52,
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (v) => _onDigitChanged(v, index),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFFE0E2EA),
                        width: 1.2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF5C6BC0),
                        width: 1.8,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        if (widget.hint != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.hint!,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFFB7BAC6),
            ),
          ),
        ],
      ],
    );
  }
}
