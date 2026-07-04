import 'package:flutter/material.dart';
import 'package:archive_secure/l10n/app_localizations.dart';

class ChangePasswordForm extends StatefulWidget {
  final void Function(String currentPassword, String newPassword) onSave;
  final bool isLoading;

  const ChangePasswordForm({
    super.key,
    required this.onSave,
    this.isLoading = false,
  });

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isExpanded = false;
  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
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
                  Icon(Icons.password, color: cs.secondary, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.profileChangePassword,
                          style: tt.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: cs.onSurface,
                          ),
                        ),
                        Text(
                          loc.profilePasswordChangeWarning,
                          style: tt.bodySmall?.copyWith(
                            color: cs.error,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                      decoration: InputDecoration(
                        labelText: loc.profileCurrentPassword,
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
                          return loc.profileCurrentPasswordRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _newCtrl,
                      obscureText: !_showNew,
                      decoration: InputDecoration(
                        labelText: loc.profileNewPassword,
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
                          return loc.profileNewPasswordRequired;
                        }
                        if (value.length < 8) {
                          return loc.profileNewPasswordMinLength;
                        }
                        if (value == _currentCtrl.text) {
                          return loc.profileNewPasswordDifferent;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _confirmCtrl,
                      obscureText: !_showConfirm,
                      decoration: InputDecoration(
                        labelText: loc.profileConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showConfirm
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () =>
                              setState(() => _showConfirm = !_showConfirm),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.profileConfirmPasswordRequired;
                        }
                        if (value != _newCtrl.text) {
                          return loc.profilePasswordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cs.error.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: cs.error, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              loc.profilePasswordChangeWarning,
                              style: tt.bodySmall?.copyWith(color: cs.error),
                            ),
                          ),
                        ],
                      ),
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
                                }
                              },
                        style: FilledButton.styleFrom(
                          backgroundColor: cs.error,
                        ),
                        child: widget.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(loc.profileChangePassword),
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
