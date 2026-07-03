import 'package:flutter/material.dart';

/// FAB circular estándar con icono "+", color configurable.
class AddFab extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;

  const AddFab({
    super.key,
    this.onPressed,
    this.color = const Color(0xFF3D5AFE),
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: color,
      elevation: 4,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
