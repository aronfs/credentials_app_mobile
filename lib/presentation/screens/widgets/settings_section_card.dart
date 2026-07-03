import 'package:flutter/material.dart';

class SettingsSectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSectionCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 7),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest.withValues(alpha: .35),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              border: Border(
                bottom: BorderSide(color: cs.outlineVariant),
              ),
            ),
            child: Text(
              title,
              style: tt.labelSmall?.copyWith(
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
              ),
            ),
          ),
          ..._withDividers(context, children),
        ],
      ),
    );
  }

  List<Widget> _withDividers(BuildContext context, List<Widget> items) {
    final cs = Theme.of(context).colorScheme;
    final result = <Widget>[];

    for (var i = 0; i < items.length; i++) {
      result.add(items[i]);
      if (i != items.length - 1) {
        result.add(Divider(
          height: 1,
          thickness: 1,
          indent: 54,
          color: cs.outlineVariant,
        ));
      }
    }

    return result;
  }
}
