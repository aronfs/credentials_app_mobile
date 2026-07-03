import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/presentation/welcome/widgets/corner_icon_badge.dart';
import 'package:archive_secure/presentation/welcome/widgets/thirdbox.dart';
import 'package:archive_secure/ui.theme/theme_app.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

@override
Widget build(BuildContext context) {
   final appLocalizations = AppLocalizations.of(context)!;
  return Theme(
    data: AppTheme.themeWelcome,
    child: Scaffold(
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ThirdBox(
              title: appLocalizations.onboardTitleThird,
              paragraph: appLocalizations.onboardParagraphThird,
              labelButton: appLocalizations.btnBacklabel,
              labelSubtitleButton: appLocalizations.btnBeginlabel,
              cardlabelFirst: appLocalizations.labelThird,
              cardlabelSecond: appLocalizations.secondlabelThird,
            ),

            Positioned(
              top: -18,
              right: -18,
              child: CornerIconBadge(
                icon: Icons.bolt,
                iconColor: Colors.blue,
                backgroundColor: Colors.white,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}