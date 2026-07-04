import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FavoritesSearchBar extends StatefulWidget {
  final void Function(String query) onSearchChanged;
  final void Function() onClear;

  const FavoritesSearchBar({
    super.key,
    required this.onSearchChanged,
    required this.onClear,
  });

  @override
  State<FavoritesSearchBar> createState() => _FavoritesSearchBarState();
}

class _FavoritesSearchBarState extends State<FavoritesSearchBar> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() => _hasText = value.isNotEmpty);
    widget.onSearchChanged(value);
  }

  void _onClear() {
    _controller.clear();
    setState(() => _hasText = false);
    widget.onClear();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;

    return TextField(
      controller: _controller,
      onChanged: _onChanged,
      decoration: InputDecoration(
        hintText: loc.favoritesSearchHint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _hasText
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _onClear,
              )
            : null,
        filled: true,
        fillColor: cs.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.secondary, width: 1.6),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
