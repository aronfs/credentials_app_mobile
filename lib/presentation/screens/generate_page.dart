import 'package:archive_secure/data/password_generator/bloc/password_generator_cubit.dart';
import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  int _length = 16;
  bool _uppercase = true;
  bool _lowercase = true;
  bool _numbers = true;
  bool _symbols = true;
  bool _excludeSimilar = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _generate();
  }

  void _generate() {
    context.read<PasswordGeneratorCubit>().generate(
      length: _length,
      includeUppercase: _uppercase,
      includeLowercase: _lowercase,
      includeNumbers: _numbers,
      includeSymbols: _symbols,
      excludeSimilarCharacters: _excludeSimilar,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(loc.passwordGeneratorTitle, style: tt.headlineMedium?.copyWith(color: cs.onSurface)),
              const SizedBox(height: 4),
              Text(loc.passwordGeneratorSubtitle,
                  style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
              const SizedBox(height: 24),
              BlocBuilder<PasswordGeneratorCubit, PasswordGeneratorState>(
                builder: (context, state) {
                  final password = state.generated?.password ?? '';
                  final score = state.generated?.score ?? 0;
                  final isGenerating = state.status == PasswordGenStatus.loading;

                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    isGenerating ? loc.passwordGeneratorGenerating : (_showPassword ? password : '••••••••••••••••'),
                                    style: tt.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: cs.onSurface,
                                      fontFamily: 'JetBrains-Mono',
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility,
                                      color: cs.onSurfaceVariant),
                                  onPressed: () => setState(() => _showPassword = !_showPassword),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.refresh, color: Colors.blue),
                                  onPressed: _generate,
                                ),
                              ],
                            ),
                            if (state.generated != null) ...[
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: score / 100,
                                  backgroundColor: cs.surfaceContainerHighest,
                                  color: score >= 80 ? Colors.green
                                      : score >= 60 ? Colors.blue
                                      : score >= 40 ? Colors.orange
                                      : Colors.red,
                                  minHeight: 6,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(state.generated!.strength == 'very_strong'
                                      ? loc.passwordGeneratorVeryStrong
                                      : state.generated!.strength == 'strong'
                                          ? loc.passwordGeneratorStrong
                                          : state.generated!.strength == 'medium'
                                              ? loc.passwordGeneratorMedium
                                              : loc.weak,
                                      style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
                                  Text('$score${loc.passwordGeneratorScoreOutOf}',
                                      style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${loc.passwordGeneratorLength}: $_length',
                                style: tt.bodyMedium?.copyWith(color: cs.onSurface, fontWeight: FontWeight.w600)),
                            Slider(
                              value: _length.toDouble(),
                              min: 8,
                              max: 64,
                              divisions: 56,
                              label: '$_length',
                              onChanged: (v) => setState(() => _length = v.round()),
                            ),
                            const SizedBox(height: 8),
                            _OptionRow(loc.passwordGeneratorUppercase, _uppercase, (v) => setState(() => _uppercase = v)),
                            _OptionRow(loc.passwordGeneratorLowercase, _lowercase, (v) => setState(() => _lowercase = v)),
                            _OptionRow(loc.passwordGeneratorNumbers, _numbers, (v) => setState(() => _numbers = v)),
                            _OptionRow(loc.passwordGeneratorSymbols, _symbols, (v) => setState(() => _symbols = v)),
                            _OptionRow(loc.passwordGeneratorAvoidSimilar, _excludeSimilar, (v) => setState(() => _excludeSimilar = v)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: isGenerating ? null : _generate,
                          icon: const Icon(Icons.refresh),
                          label: Text(loc.passwordGeneratorGenerate),
                        ),
                      ),
                      if (password.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: password));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(loc.passwordGeneratorCopied)),
                              );
                            },
                            icon: const Icon(Icons.copy),
                            label: Text(loc.passwordGeneratorCopy),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _OptionRow(this.label, this.value, this.onChanged);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurface)),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}