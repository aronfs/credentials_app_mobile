import 'package:flutter/material.dart';

class EditProfileNameForm extends StatefulWidget {
  final String currentName;
  final void Function(String name) onSave;
  final bool isLoading;

  const EditProfileNameForm({
    super.key,
    required this.currentName,
    required this.onSave,
    this.isLoading = false,
  });

  @override
  State<EditProfileNameForm> createState() => _EditProfileNameFormState();
}

class _EditProfileNameFormState extends State<EditProfileNameForm> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentName);
  }

  @override
  void didUpdateWidget(EditProfileNameForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentName != widget.currentName) {
      _controller.text = widget.currentName;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.edit_outlined, color: cs.secondary, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    'Editar nombre',
                    style: tt.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(Icons.expand_more, color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Nombre completo',
                        hintText: 'Tu nombre',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'El nombre es requerido';
                        }
                        if (value.trim().length < 2) {
                          return 'Mínimo 2 caracteres';
                        }
                        if (value.trim().length > 80) {
                          return 'Máximo 80 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: widget.isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  widget.onSave(_controller.text.trim());
                                }
                              },
                        child: widget.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Guardar cambios'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
