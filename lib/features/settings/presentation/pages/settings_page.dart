import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const _languages = [
    (code: 'en', label: 'English'),
    (code: 'ar', label: 'العربية'),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settings = context.watch<SettingsCubit>().state;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _Section(
          title: l10n.settingsAppearance,
          children: [
            SegmentedButton<ThemeMode>(
              segments: [
                ButtonSegment(value: ThemeMode.system, icon: const Icon(Icons.brightness_auto), label: Text(l10n.themeSystem)),
                ButtonSegment(value: ThemeMode.light,  icon: const Icon(Icons.light_mode),     label: Text(l10n.themeLight)),
                ButtonSegment(value: ThemeMode.dark,   icon: const Icon(Icons.dark_mode),      label: Text(l10n.themeDark)),
              ],
              selected: {settings.themeMode},
              onSelectionChanged: (s) =>
                context.read<SettingsCubit>().setTheme(s.first),
              showSelectedIcon: false,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _Section(
          title: l10n.settingsLanguage,
          children: [
            for (final lang in _languages)
              RadioListTile<String>(
                value: lang.code,
                groupValue: settings.locale.languageCode,
                onChanged: (v) {
                  if (v != null) {
                    context.read<SettingsCubit>().setLocale(Locale(v));
                  }
                },
                title: Text(lang.label),
                contentPadding: EdgeInsets.zero,
                activeColor: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: t.titleMedium),
            const SizedBox(height: AppSpacing.md),
            ...children,
          ],
        ),
      ),
    );
  }
}