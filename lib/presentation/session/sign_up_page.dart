import 'package:archive_secure/data/auth/bloc/auth_bloc.dart';
import 'package:archive_secure/data/auth/bloc/auth_event.dart';
import 'package:archive_secure/data/auth/bloc/auth_state.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/navigation/route.dart';
import 'package:archive_secure/presentation/session/widgets/create_account_button.dart';
import 'package:archive_secure/presentation/session/widgets/form_page_header.dart';
import 'package:archive_secure/presentation/session/widgets/password_strength_bar.dart';
import 'package:archive_secure/presentation/session/widgets/pin_input_field.dart';
import 'package:archive_secure/presentation/session/widgets/register_text_field.dart';
import 'package:archive_secure/ui.theme/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  PasswordStrength _strength = PasswordStrength.empty;
  String _pin = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onPasswordChanged(String value) {
    setState(() {
      _strength = PasswordStrengthExt.evaluate(value);
    });
  }

  void _onCreateAccount() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || _pin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.requiredField),
          backgroundColor: Colors.red.shade700,
        ),
      );
      return;
    }
    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.requiredField),
          backgroundColor: Colors.red.shade700,
        ),
      );
      return;
    }
    context
        .read<AuthBloc>()
        .add(RegisterSubmitted(name: name, email: email, password: password, pin: _pin));
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Theme(
      data: AppTheme.themeForms,
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                welcomePage,
                (route) => false,
              );
            }
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red.shade700,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F6FA),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              FormPageHeader(
                                title: loc.signUpTitle,
                                subtitle: loc.signUpSubtitle,
                              ),
                              const SizedBox(height: 22),
                              RegisterTextField(
                                label: loc.signUpNameLabel,
                                hintText: loc.signUpNameHint,
                                prefixIcon: Icons.person_outline,
                                controller: _nameController,
                                keyboardType: TextInputType.name,
                              ),
                              const SizedBox(height: 14),
                              RegisterTextField(
                                label: loc.signUpEmailLabel,
                                hintText: loc.signUpEmailHint,
                                prefixIcon: Icons.mail_outline,
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 14),
                              RegisterTextField(
                                label: loc.signUpPasswordLabel,
                                hintText: loc.signUpPasswordHint,
                                prefixIcon: Icons.lock_outline,
                                isPassword: true,
                                controller: _passwordController,
                                onChanged: _onPasswordChanged,
                              ),
                              const SizedBox(height: 8),
                              PasswordStrengthBar(
                                strength: _strength,
                                labels: {
                                  PasswordStrength.weak: loc.weak,
                                  PasswordStrength.medium: loc.medium,
                                  PasswordStrength.strong: loc.strong,
                                },
                              ),
                              const SizedBox(height: 14),
                              RegisterTextField(
                                label: loc.signUpConfirmLabel,
                                hintText: loc.signUpConfirmHint,
                                prefixIcon: Icons.lock_outline,
                                isPassword: true,
                                controller: _confirmController,
                              ),
                              const SizedBox(height: 20),
                              PinInputField(
                                length: 4,
                                label: loc.signUpPinLabel,
                                hint: loc.signUpPinHint,
                                onCompleted: (pin) => setState(() => _pin = pin),
                                onChanged: (pin) => setState(() => _pin = pin),
                              ),
                              const SizedBox(height: 22),
                              CreateAccountButton(
                                label: loc.signUpCreateButton,
                                onPressed: isLoading ? null : _onCreateAccount,
                                isLoading: isLoading,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AlreadyHaveAccountLink(
                    label: loc.signUpAlreadyHaveAccount,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}