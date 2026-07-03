import 'package:archive_secure/presentation/welcome/widgets/onboarding_diamond_illustration.dart';
import 'package:archive_secure/presentation/welcome/widgets/onboarding_feature.dart';
import 'package:archive_secure/presentation/welcome/widgets/onboarding_feature_card.dart';
import 'package:archive_secure/presentation/welcome/widgets/onboarding_text_block.dart';
import 'package:archive_secure/ui.theme/size_app.dart';
import 'package:archive_secure/ui.theme/styles/button_style_app.dart';
import 'package:flutter/material.dart';

class SecondBox extends StatelessWidget {
  final String title;
  final String paragraph;
  final String titleFirts;
  final String paragraphFirts;
  final String titleSecond;
  final String paragraphSecond;
  final String onTapPage;
  final String titleButton;
  final String subtitleButton;

  const SecondBox({
    super.key,
    required this.title,
    required this.paragraph,
    required this.titleFirts,
    required this.paragraphFirts,
    required this.titleSecond,
    required this.paragraphSecond,
    required this.onTapPage,
    required this.titleButton,
    required this.subtitleButton,
  });

  List<OnboardingFeature> get _features => [
    OnboardingFeature(
      icon: Icons.shield_outlined,
      iconColor: const Color(0xFF2962FF),
      iconBackgroundColor: const Color(0xFFDCE6FB),
      title: titleFirts,
      description: paragraphFirts,
    ),
    OnboardingFeature(
      icon: Icons.fingerprint,
      iconColor: const Color(0xFF2962FF),
      iconBackgroundColor: const Color(0xFFDCE6FB),
      title: titleSecond,
      description: paragraphSecond,
    ),
  ];

  void _onTap(BuildContext context, String page) {
    Navigator.pushNamed(context, page);
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
            const OnboardingDiamondIllustration(icon: Icons.lock_outline),

            const SizedBox(height: 28),

            OnboardingTextBlock(title: title, description: paragraph),

            const SizedBox(height: 24),

            for (int i = 0; i < _features.length; i++) ...[
              OnboardingFeatureCard(feature: _features[i]),
              if (i != _features.length - 1) const SizedBox(height: 10),
            ],
            const SizedBox(height: 12),
            SizedBox(
              width: sizeButton.width,
              height: sizeButton.height,
              child: ElevatedButton(
                onPressed: () => _onTap(context, onTapPage),
                style: blueButtonStyle,
                child: Text(titleButton),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: sizeButton.width,
              height: sizeButton.height,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(subtitleButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
