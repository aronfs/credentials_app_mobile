import 'package:archive_secure/app/app_dependencies.dart';
import 'package:archive_secure/app/archive_secure_app.dart';
import 'package:archive_secure/core/theme/theme_mode_controller.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadStoredThemeMode();

  runApp(ArchiveSecureApp(dependencies: AppDependencies.create()));
}
