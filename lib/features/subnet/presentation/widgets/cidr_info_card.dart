import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:subnetter/l10n/app_localizations.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/cidr_info.dart';

/// CIDR details for one block.
///
/// Expansion is *controlled* by the parent so the open/closed state survives
/// the card being scrolled out of the viewport and rebuilt.
class CidrInfoCard extends StatelessWidget {
  final CidrInfo info;
  final bool expanded;
  final ValueChanged<bool> onExpansionChanged;

  const CidrInfoCard({
    super.key,
    required this.info,
    required this.expanded,
    required this.onExpansionChanged,
  });

  String _plainText() {
    final i = info;
    return 'CIDR: ${i.cidr}\n'
        '  Network         : ${i.networkAddress}\n'
        '  Broadcast       : ${i.broadcast}\n'
        '  First usable    : ${i.firstUsable}\n'
        '  Last usable     : ${i.lastUsable}\n'
        '  Netmask         : ${i.netmask}\n'
        '  Wildcard        : ${i.wildcard}\n'
        '  Total addresses : ${i.totalAddresses}\n'
        '  Usable hosts    : ${i.usableAddresses}\n'
        '  IP class        : ${i.ipClass}\n'
        '  Private         : ${i.isPrivate ? 'yes' : 'no'}\n';
  }

  Future<void> _copy(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    await Clipboard.setData(ClipboardData(text: _plainText()));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.cidrInfoCopied),
          duration: Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          // ----- Header (primary) -----
          Material(
            color: scheme.primary,
            child: InkWell(
              onTap: () => onExpansionChanged(!expanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: Row(
                  children: [
                    Icon(Icons.hub_outlined, size: 18, color: scheme.onPrimary),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        info.cidr,
                        style: t.titleMedium?.copyWith(
                          color: scheme.onPrimary,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.copyCIDRInfo,
                      splashRadius: 20,
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.copy_rounded,
                        size: 18,
                        color: scheme.onPrimary,
                      ),
                      onPressed: () => _copy(context),
                    ),
                    Icon(
                      expanded
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                      color: scheme.onPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ----- Body -----
          // The open/closed state comes from the parent, so a card that is
          // scrolled out of the viewport and rebuilt comes back in the state the
          // user left it in instead of collapsing.
          AnimatedSize(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: expanded
                ? Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Table(
                      // The label column is sized to its widest label, so
                      // every value starts at the same x and the rows read as
                      // one aligned column. The value column takes the rest.
                      columnWidths: const {
                        0: IntrinsicColumnWidth(),
                        1: FlexColumnWidth(),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      children: [
                        _row(context, l10n.network, info.networkAddress),
                        _row(context, l10n.broadcast, info.broadcast),
                        _row(context, l10n.firstUsable, info.firstUsable),
                        _row(context, l10n.lastUsable, info.lastUsable),
                        _row(context, l10n.netmask, info.netmask),
                        _row(context, l10n.wildcard, info.wildcard),
                        _row(
                          context,
                          l10n.totalAddresses,
                          '${info.totalAddresses}',
                          mono: false,
                        ),
                        _row(
                          context,
                          l10n.usableHosts,
                          '${info.usableAddresses}',
                          mono: false,
                        ),
                        _row(context, l10n.ipClass, info.ipClass, mono: false),
                        _row(
                          context,
                          l10n.private,
                          info.isPrivate ? '✔' : '✘',
                          valueColor: info.isPrivate
                              ? Colors.green
                              : scheme.error,
                          mono: false,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }

  /// One aligned label/value row. The label column is intrinsic (shared by
  /// every row of the [Table]) and the value column absorbs the remaining
  /// width, so both stay inside the card at any pane width or font scale.
  TableRow _row(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
    bool mono = true,
  }) {
    final t = Theme.of(context).textTheme;
    final ext = context.ext;
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(
            end: AppSpacing.md,
            top: AppSpacing.xs,
            bottom: AppSpacing.xs,
          ),
          child: Text(
            label,
            style: t.bodyMedium?.copyWith(color: ext.textMuted),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: SelectableText(
            value,
            style: t.bodyMedium?.copyWith(
              fontFamily: mono ? 'monospace' : null,
              fontWeight: FontWeight.w500,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}
