import 'package:archive_secure/domain/entities/credential_entity.dart';

String formatRelativeDate(DateTime? date) {
  if (date == null) return 'Sin fecha';
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final dateDay = DateTime(date.year, date.month, date.day);

  final diff = today.difference(dateDay).inDays;

  if (diff == 0) return 'Hoy';
  if (diff == 1) return 'Ayer';

  return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}

String credentialIdentifier(CredentialEntity credential) {
  if (credential.loginEmail != null && credential.loginEmail!.isNotEmpty) {
    return credential.loginEmail!;
  }
  if (credential.username != null && credential.username!.isNotEmpty) {
    return credential.username!;
  }
  return 'Sin identificador';
}
