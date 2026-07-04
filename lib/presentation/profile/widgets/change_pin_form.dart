import 'package:flutter/material.dart';
import 'package:archive_secure/l10n/app_localizations.dart';

class ChangePinForm extends StatefulWidget {
  final void Function(String currentPin, String newPin) onSave;
  final bool isLoading;

  const ChangePinForm({
    super.key,
    required this.onSave,
    this.isLoading = false,
  });

  @override
  State<ChangePinForm> createState() => _ChangePinFormState();
}

class _ChangePinFormState extends State<ChangePinForm> {
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isExpanded = false;
  bool _showCurrent = false;
  bool _showNew = false;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
                  Icon(Icons.pin_outlined, color: cs.secondary, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    loc.profileChangePin,
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
                      controller: _currentCtrl,
                      obscureText: !_showCurrent,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: loc.profileCurrentPin,
                        counterText: '',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showCurrent
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () =>
                              setState(() => _showCurrent = !_showCurrent),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.profileCurrentPinRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _newCtrl,
                      obscureText: !_showNew,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: loc.profileNewPin,
                        counterText: '',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showNew ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () =>
                              setState(() => _showNew = !_showNew),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.profileNewPinRequired;
                        }
                        if (value.length < 4 || value.length > 6) {
                          return loc.profileNewPinLength;
                        }
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return loc.profileNewPinDigits;
                        }
                        if (value == _currentCtrl.text) {
                          return loc.profileNewPinDifferent;
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
                                  widget.onSave(
                                    _currentCtrl.text,
                                    _newCtrl.text,
                                  );
                                  _isExpanded = false;
                                  _currentCtrl.clear();
                                  _newCtrl.clear();
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
                            : Text(loc.profileChangePin),
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
