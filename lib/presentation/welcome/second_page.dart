import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/navigation/route.dart';
import 'package:archive_secure/presentation/welcome/widgets/secondbox.dart';
import 'package:archive_secure/ui.theme/theme_app.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

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
                 SecondBox(
                    title: appLocalizations.titleSecondPage,
                    paragraph: appLocalizations.paragraphSecondPage,
                    titleFirts: appLocalizations.onboardTitle,
                    paragraphFirts: appLocalizations.onboardParagraph,
                    titleSecond: appLocalizations.onboardTitleSecond,
                    paragraphSecond: appLocalizations.onboardParagraphSecond,
                    onTapPage: thirdPage,
                    titleButton: appLocalizations.next,
                    subtitleButton: appLocalizations.skip,
                  )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}