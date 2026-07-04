import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CredentialsSearchField extends StatefulWidget {
  final void Function(String query) onSearch;

  const CredentialsSearchField({super.key, required this.onSearch});

  @override
  State<CredentialsSearchField> createState() => _CredentialsSearchFieldState();
}

class _CredentialsSearchFieldState extends State<CredentialsSearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;

    return TextField(
      controller: _controller,
      onSubmitted: (value) => widget.onSearch(value),
      decoration: InputDecoration(
        hintText: loc.credentialSearch,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  widget.onSearch('');
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        filled: true,
        fillColor: cs.surface,
      ),
    );
  }
}
