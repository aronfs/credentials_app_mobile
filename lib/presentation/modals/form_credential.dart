import 'dart:async';

import 'package:archive_secure/data/categories/bloc/category_bloc.dart';
import 'package:archive_secure/data/categories/bloc/category_event.dart';
import 'package:archive_secure/data/categories/bloc/category_state.dart';
import 'package:archive_secure/data/categories/domain/entity/category.dart';
import 'package:archive_secure/data/credentials/domain/entity/credential.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormCredential extends StatefulWidget {
  final Credential? credential;

  const FormCredential({super.key, this.credential});

  bool get isEditing => credential != null;

  @override
  State<FormCredential> createState() => _FormCredentialState();
}

class _FormCredentialState extends State<FormCredential> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _serviceNameCtrl;
  late final TextEditingController _loginEmailCtrl;
  late final TextEditingController _usernameCtrl;
  late final TextEditingController _passwordCtrl;
  late final TextEditingController _notesCtrl;
  late final TextEditingController _tagsCtrl;
  late final StreamSubscription<CategoryState> _categorySubscription;

  String? _selectedCategoryId;
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _serviceNameCtrl = TextEditingController(
      text: widget.credential?.serviceName ?? '',
    );
    _loginEmailCtrl = TextEditingController(
      text: widget.credential?.loginEmail ?? '',
    );
    _usernameCtrl = TextEditingController(
      text: widget.credential?.username ?? '',
    );
    _passwordCtrl = TextEditingController();
    _notesCtrl = TextEditingController(text: widget.credential?.notes ?? '');
    _tagsCtrl = TextEditingController(
      text: widget.credential?.tags.join(', ') ?? '',
    );
    _selectedCategoryId = widget.credential?.categoryId;
    _loadCategories();
  }

  void _loadCategories() {
    final categoryBloc = context.read<CategoryBloc>();
    final state = categoryBloc.state;
    if (state is CategoriesLoaded) {
      _categories = state.categories;
    } else {
      categoryBloc.add(LoadCategories());
    }
    _categorySubscription = categoryBloc.stream.listen((state) {
      if (state is CategoriesLoaded && mounted) {
        setState(() => _categories = state.categories);
      }
    });
  }

  @override
  void dispose() {
    _serviceNameCtrl.dispose();
    _loginEmailCtrl.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    _notesCtrl.dispose();
    _tagsCtrl.dispose();
    _categorySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        surfaceTintColor: cs.surface,
        title: Text(
          widget.isEditing ? loc.credentialEdit : loc.credentialCreate,
          style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _serviceNameCtrl,
                decoration: InputDecoration(
                  labelText: loc.credentialServiceName,
                  hintText: loc.credentialServiceNameHint,
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? loc.requiredField : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _loginEmailCtrl,
                decoration: InputDecoration(
                  labelText: loc.credentialLoginEmail,
                  hintText: loc.credentialLoginEmailHint,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _usernameCtrl,
                decoration: InputDecoration(
                  labelText: loc.credentialUsername,
                  hintText: loc.credentialUsernameHint,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordCtrl,
                decoration: InputDecoration(
                  labelText: widget.isEditing
                      ? loc.credentialPasswordKeepHint
                      : loc.credentialPassword,
                  hintText: loc.credentialPasswordHint,
                ),
                obscureText: true,
                validator: (v) {
                  if (!widget.isEditing && (v == null || v.trim().isEmpty)) {
                    return loc.requiredField;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesCtrl,
                decoration: InputDecoration(
                  labelText: loc.credentialNotes,
                  hintText: loc.credentialNotesHint,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategoryId,
                decoration: InputDecoration(labelText: loc.credentialCategory),
                items: [
                  DropdownMenuItem<String>(
                    value: null,
                    child: Text(loc.credentialNoCategory),
                  ),
                  ..._categories.map(
                    (cat) => DropdownMenuItem<String>(
                      value: cat.id,
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _parseColor(cat.color),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(cat.name),
                        ],
                      ),
                    ),
                  ),
                ],
                onChanged: (v) => setState(() => _selectedCategoryId = v),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tagsCtrl,
                decoration: InputDecoration(
                  labelText: loc.credentialTags,
                  hintText: loc.credentialTagsHint,
                ),
              ),
              const SizedBox(height: 32),
              FilledButton(onPressed: _submit, child: Text(loc.credentialSave)),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(loc.credentialCancel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final tags = _tagsCtrl.text.isNotEmpty
        ? _tagsCtrl.text
              .split(',')
              .map((tag) => tag.trim())
              .where((tag) => tag.isNotEmpty)
              .toList()
        : <String>[];

    final data = <String, dynamic>{
      'serviceName': _serviceNameCtrl.text.trim(),
      if (_loginEmailCtrl.text.trim().isNotEmpty)
        'loginEmail': _loginEmailCtrl.text.trim(),
      if (_usernameCtrl.text.trim().isNotEmpty)
        'username': _usernameCtrl.text.trim(),
      if (_passwordCtrl.text.isNotEmpty) 'password': _passwordCtrl.text,
      if (_notesCtrl.text.trim().isNotEmpty) 'notes': _notesCtrl.text.trim(),
      if (_selectedCategoryId != null) 'categoryId': _selectedCategoryId,
      'tags': tags,
    };
    Navigator.of(context).pop(data);
  }

  Color _parseColor(String hex) {
    final h = hex.replaceFirst('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }
}
