import 'package:flutter/material.dart';

class LoginSubmitButton extends StatelessWidget {
  final String label;
  final String? loadingLabel;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color color;

  const LoginSubmitButton({
    super.key,
    required this.label,
    this.loadingLabel,
    this.onPressed,
    this.isLoading = false,
    this.color = const Color(0xFF1A1A2E),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: isLoading ? null : onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: color,
                  ),
                )
              : Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
        ),
      ),
    );
  }
}
