import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/responsive/responsive_metrics.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/settings_cubit.dart';
import 'terms_page.dart';

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
    final gutter = context.sizeClass.gutter;

    return context.constrainContentWidth(
      ListView(
        padding: EdgeInsets.symmetric(
          horizontal: gutter,
          vertical: context.sizeClass.blockGap,
        ),
        children: [
          _Section(
            title: l10n.settingsAppearance,
            children: [
              SegmentedButton<ThemeMode>(
                segments: [
                  ButtonSegment(
                    value: ThemeMode.system,
                    icon: const Icon(Icons.brightness_auto),
                    label: Text(l10n.themeSystem),
                  ),
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: const Icon(Icons.light_mode),
                    label: Text(l10n.themeLight),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: const Icon(Icons.dark_mode),
                    label: Text(l10n.themeDark),
                  ),
                ],
                selected: {settings.themeMode},
                onSelectionChanged: (s) =>
                    context.read<SettingsCubit>().setTheme(s.first),
                showSelectedIcon: false,
              ),
            ],
          ),
          SizedBox(height: context.sizeClass.blockGap),
          _Section(
            title: l10n.settingsLanguage,
            children: [
              RadioGroup<String>(
                groupValue: settings.locale.languageCode,
                onChanged: (v) {
                  if (v != null) {
                    context.read<SettingsCubit>().setLocale(Locale(v));
                  }
                },
                child: Column(
                  spacing: AppSpacing.sm,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final lang in _languages)
                      RadioListTile<String>(
                        value: lang.code,
                        title: Text(lang.label),
                        contentPadding: EdgeInsets.zero,
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.sizeClass.blockGap),
          Card(
            child: ListTile(
              leading: const Icon(Icons.menu_book_outlined),
              title: Text(l10n.settingsTerms),
              subtitle: Text(l10n.settingsTermsSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const TermsPage()),
              ),
            ),
          ),
          SizedBox(height: context.sizeClass.blockGap),
          _Section(title: l10n.settingsAbout, children: const [_AboutCard()]),
        ],
      ),
    );
  }
}

class _AboutCard extends StatefulWidget {
  const _AboutCard();

  @override
  State<_AboutCard> createState() => _AboutCardState();
}

class _AboutCardState extends State<_AboutCard> {
  late final Future<PackageInfo> _info = PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.appTitle, style: t.titleMedium),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.appDescription,
          style: t.bodyMedium?.copyWith(color: context.ext.textMuted),
        ),
        const SizedBox(height: AppSpacing.md),
        FutureBuilder<PackageInfo>(
          future: _info,
          builder: (context, snapshot) {
            final info = snapshot.data;
            final version = info == null ? '…' : info.version;
            return Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18,
                  color: context.ext.textMuted,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '${l10n.versionLabel}: $version',
                  style: t.bodyMedium?.copyWith(color: context.ext.textMuted),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Icon(
              Icons.developer_mode_rounded,
              color: context.ext.textMuted,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              '${l10n.developer} Omar Bjjash',
              style: t.bodyMedium?.copyWith(color: context.ext.textMuted),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: <Widget>[
            Icon(
              Icons.device_hub_rounded,
              size: 20,
              color: context.ext.textMuted,
            ),
            const SizedBox(width: AppSpacing.sm),
            Row(
              children: [
                Text(
                  'GitHub: ',
                  style: TextStyle(color: context.ext.textMuted),
                ),
                GestureDetector(
                  onTap: () {},
                  behavior: HitTestBehavior.translucent,
                  child: Text(
                    'https://github.com/OmarBjjash/subnetter',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
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
          spacing: 4,
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
