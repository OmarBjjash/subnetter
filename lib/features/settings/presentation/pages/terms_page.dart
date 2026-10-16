import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_metrics.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';

/// A glossary of the networking terms used across the app, each with a
/// plain-language explanation. Content is fully localized.
class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = Theme.of(context).textTheme;
    final gutter = context.sizeClass.gutter;

    // (term, definition) pairs. Keeping them here means a new term is a
    // single entry that stays next to the others.
    final terms = <(String, String)>[
      (l10n.termVlsm, l10n.termVlsmDef),
      (l10n.termCidr, l10n.termCidrDef),
      (l10n.termIpAddress, l10n.termIpAddressDef),
      (l10n.termSubnet, l10n.termSubnetDef),
      (l10n.termSubnetMask, l10n.termSubnetMaskDef),
      (l10n.termPrefixLength, l10n.termPrefixLengthDef),
      (l10n.termNetworkAddress, l10n.termNetworkAddressDef),
      (l10n.termBroadcastAddress, l10n.termBroadcastAddressDef),
      (l10n.termFirstUsable, l10n.termFirstUsableDef),
      (l10n.termLastUsable, l10n.termLastUsableDef),
      (l10n.termWildcard, l10n.termWildcardDef),
      (l10n.termUsableHosts, l10n.termUsableHostsDef),
      (l10n.termTotalAddresses, l10n.termTotalAddressesDef),
      (l10n.termIpClass, l10n.termIpClassDef),
      (l10n.termPrivateIp, l10n.termPrivateIpDef),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.termsTitle)),
      body: context.constrainContentWidth(
        ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: gutter,
            vertical: context.sizeClass.blockGap,
          ),
          itemCount: terms.length + 1,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Text(
                  l10n.termsSubtitle,
                  style: t.bodyMedium?.copyWith(color: context.ext.textMuted),
                ),
              );
            }
            final (name, definition) = terms[index - 1];
            return _TermCard(name: name, definition: definition);
          },
        ),
      ),
    );
  }
}

class _TermCard extends StatelessWidget {
  const _TermCard({required this.name, required this.definition});

  final String name;
  final String definition;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: t.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              definition,
              style: t.bodyMedium?.copyWith(color: context.ext.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
