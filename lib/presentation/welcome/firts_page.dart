import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/navigation/route.dart';
import 'package:archive_secure/presentation/welcome/constants/constanst.dart';
import 'package:archive_secure/presentation/welcome/widgets/box.dart';
import 'package:archive_secure/ui.theme/theme_app.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final appLocalizations = AppLocalizations.of(context)!;
    return Theme(
      data: AppTheme.themeWelcome,
      child: Scaffold(
  body: Center(
    child: Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150),
              child: Image.asset(imageMain),
            ),
            const SizedBox(height: 40),
            Box(
              title: appLocalizations.welcome,
              paragraph: appLocalizations.paragraph,
              subtitleButton: appLocalizations.skip,
              titleButton: appLocalizations.next,
              onTapPage: secondPage,
            ),
          ],
        ),
      ],
    ),
  ),
)
      );
  }
}