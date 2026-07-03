import 'package:flutter/material.dart';

/// Bloque de links de cuenta: "Crear cuenta" en azul resaltado y
/// "Olvidé mi contraseña" en gris, centrados y apilados.
class AccountLinksGroup extends StatelessWidget {
  final VoidCallback? onCreateAccount;
  final VoidCallback? onForgotPassword;

  final String lblCreateAccount;
  final String lblForgotPassword;



  const AccountLinksGroup({
    super.key,
    this.onCreateAccount,
    this.onForgotPassword,
    required this.lblCreateAccount,
    required this.lblForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onCreateAccount,
          child:  Text(
            lblCreateAccount,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3D5AFE),
              decoration: TextDecoration.none,
            ),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onForgotPassword,
          child:  Text(
            lblForgotPassword,
            style: TextStyle(
              fontSize: 13.5,
              color: Color(0xFF9A9DB0),
            ),
          ),
        ),
      ],
    );
  }
}
