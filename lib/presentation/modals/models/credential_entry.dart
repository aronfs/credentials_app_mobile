import 'package:flutter/material.dart';

class CredentialEntry {
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String name;
  final String username;

  const CredentialEntry({
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.name,
    required this.username,
  });
}
