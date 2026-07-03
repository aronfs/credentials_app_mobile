import 'package:archive_secure/navigation/route.dart';
import 'package:archive_secure/presentation/welcome/widgets/back_outline_button.dart';
import 'package:archive_secure/presentation/welcome/widgets/onboarding_text_block.dart';
import 'package:archive_secure/presentation/welcome/widgets/start_button.dart';
import 'package:archive_secure/presentation/welcome/widgets/vault_preview_card.dart';
import 'package:flutter/material.dart';

class ThirdBox extends StatelessWidget {

  final String title;
  final String paragraph;
  final String labelButton;
  final String labelSubtitleButton;
  final String cardlabelFirst;
  final String cardlabelSecond;



  const ThirdBox({
    super.key,
    required this.title,
    required this.paragraph,
    required this.labelButton,
    required this.labelSubtitleButton,
    required this.cardlabelFirst,
    required this.cardlabelSecond,
  });


  void _onTapBack(BuildContext context, String pageBack) {
    Navigator.pushNamed(context, pageBack);
  }

  void _onTapStart(BuildContext context, String pageStart) {
    Navigator.pushNamed(context, pageStart);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      borderRadius: BorderRadius.circular(16),
      shadowColor: Colors.black45,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           

            const SizedBox(height: 16),

            VaultPreviewCard(
              title: cardlabelFirst,
              subtitle: cardlabelSecond,
            ),

            const SizedBox(height: 28),

             OnboardingTextBlock(
              title: title,
              description: paragraph
            ),

            const SizedBox(height: 200),

            SizedBox(
              width: double.infinity,
              child: BackOutlineButton(
                label: labelButton,
                onPressed: () => _onTapBack(context, secondPage),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: StartButton(
                label: labelSubtitleButton,
                color: const Color(0xFF3D3DBF),
                onPressed: () => _onTapStart(context, signInPage),
              ),
            ),
          ],
        ),
      ),
    );
  }
}