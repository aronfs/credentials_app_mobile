import 'package:archive_secure/data/categories/domain/entity/category.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FormCategory extends StatefulWidget {
  final Category? category;

  const FormCategory({super.key, this.category});

  bool get isEditing => category != null;

  @override
  State<FormCategory> createState() => _FormCategoryState();
}

class _FormCategoryState extends State<FormCategory> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late String _selectedColor;
  late String _selectedIcon;

  static const List<ColorOption> _colorOptions = [
    ColorOption(label: 'Azul', value: '#3b82f6'),
    ColorOption(label: 'Rojo', value: '#ef4444'),
    ColorOption(label: 'Verde', value: '#22c55e'),
    ColorOption(label: 'Amarillo', value: '#eab308'),
    ColorOption(label: 'Purpura', value: '#a855f7'),
    ColorOption(label: 'Rosa', value: '#ec4899'),
    ColorOption(label: 'Naranja', value: '#f97316'),
    ColorOption(label: 'Gris', value: '#6b7280'),
  ];

  static const List<IconOption> _iconOptions = [
    IconOption(label: 'Globo', icon: Icons.public),
    IconOption(label: 'Persona', icon: Icons.person_outline),
    IconOption(label: 'Trabajo', icon: Icons.work_outline),
    IconOption(label: 'Banco', icon: Icons.account_balance_outlined),
    IconOption(label: 'Email', icon: Icons.mail_outline),
    IconOption(label: 'Telefono', icon: Icons.phone_outlined),
    IconOption(label: 'WiFi', icon: Icons.wifi),
    IconOption(label: 'Estudio', icon: Icons.school_outlined),
    IconOption(label: 'Shield', icon: Icons.shield_outlined),
    IconOption(label: 'Cloud', icon: Icons.cloud_outlined),
    IconOption(label: 'Star', icon: Icons.star_outline),
    IconOption(label: 'Heart', icon: Icons.favorite_outline),
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name ?? '');
    _selectedColor = widget.category?.color ?? '#3b82f6';
    _selectedIcon = widget.category?.icon ?? 'globo';
  }

  @override
  void dispose() {
    _nameController.dispose();
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
          widget.isEditing ? loc.categoryEdit : loc.categoryCreate,
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
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: loc.categoryName,
                  hintText: loc.categoryNameHint,
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? loc.requiredField : null,
              ),
              const SizedBox(height: 24),
              Text(
                loc.categoryColor,
                style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _colorOptions.map((option) {
                  final isSelected = _selectedColor == option.value;
                  return Tooltip(
                    message: option.label,
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _selectedColor = option.value),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: _parseColor(option.value),
                          borderRadius: BorderRadius.circular(10),
                          border: isSelected
                              ? Border.all(color: cs.onSurface, width: 2.5)
                              : null,
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Text(
                loc.categoryIcon,
                style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _iconOptions.map((option) {
                  final isSelected =
                      _selectedIcon == option.label.toLowerCase();
                  return Tooltip(
                    message: option.label,
                    child: GestureDetector(
                      onTap: () => setState(
                        () => _selectedIcon = option.label.toLowerCase(),
                      ),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _parseColor(
                                  _selectedColor,
                                ).withValues(alpha: .15)
                              : cs.surfaceContainerHighest.withValues(
                                  alpha: .5,
                                ),
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected
                              ? Border.all(
                                  color: _parseColor(_selectedColor),
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Icon(
                          option.icon,
                          size: 24,
                          color: isSelected
                              ? _parseColor(_selectedColor)
                              : cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
              FilledButton(onPressed: _submit, child: Text(loc.categorySave)),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(loc.categoryCancel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.of(context).pop({
      'name': _nameController.text.trim(),
      'color': _selectedColor,
      'icon': _selectedIcon,
    });
  }

  Color _parseColor(String hex) {
    final h = hex.replaceFirst('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }
}

class ColorOption {
  final String label;
  final String value;

  const ColorOption({required this.label, required this.value});
}

class IconOption {
  final String label;
  final IconData icon;

  const IconOption({required this.label, required this.icon});
}
