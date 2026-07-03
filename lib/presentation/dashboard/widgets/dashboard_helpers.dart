import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color colorFromHex(String hex) {
  try {
    final h = hex.replaceFirst('#', '');
    if (h.length == 6) {
      return Color(int.parse('FF$h', radix: 16));
    }
    if (h.length == 8) {
      return Color(int.parse(h, radix: 16));
    }
  } catch (_) {}
  return const Color(0xFF6366F1);
}

IconData iconFromString(String icon) {
  switch (icon) {
    case 'users':
      return Icons.people;
    case 'code':
      return Icons.code;
    case 'banknote':
      return Icons.account_balance;
    case 'shopping-cart':
      return Icons.shopping_cart;
    case 'mail':
      return Icons.mail;
    case 'folder':
      return Icons.folder;
    default:
      return Icons.folder;
  }
}

String formatDashboardDate(DateTime? date, AppLocalizations loc) {
  if (date == null) return loc.dashboardNoDate;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final dateDay = DateTime(date.year, date.month, date.day);
  final diff = today.difference(dateDay).inDays;

  if (diff == 0) return loc.dashboardToday;
  if (diff == 1) return loc.dashboardYesterday;
  return DateFormat('dd/MM/yyyy').format(date);
}
