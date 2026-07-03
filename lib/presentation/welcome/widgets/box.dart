import 'package:archive_secure/ui.theme/size_app.dart';
import 'package:archive_secure/ui.theme/styles/button_style_app.dart';
import 'package:archive_secure/ui.theme/styles/text_style_app.dart';
import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final String title;
  final String paragraph;
  final String titleButton;
  final String subtitleButton;
  final String onTapPage;


  const Box({
    super.key, 
    required this.title, required this.paragraph, required this.subtitleButton, required this.titleButton, required this.onTapPage
});

  void _onTap(BuildContext context, String page){
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
        Text(
          title,
          style: textStylePrimary.headlineMedium,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 12),

        Text(
          paragraph,
          style: textStyleSecondary.displaySmall,
          textAlign: TextAlign.center,
          softWrap: true,
        ),

        const SizedBox(height: 24),

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