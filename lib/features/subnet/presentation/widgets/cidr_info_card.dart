import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:subnetter/l10n/app_localizations.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/cidr_info.dart';

class CidrInfoCard extends StatefulWidget {
  final CidrInfo info;
  final bool initiallyExpanded;

  const CidrInfoCard({
    super.key,
    required this.info,
    this.initiallyExpanded = true,
  });

  @override
  State<CidrInfoCard> createState() => _CidrInfoCardState();
}

class _CidrInfoCardState extends State<CidrInfoCard> {
  late bool _expanded = widget.initiallyExpanded;

  String _plainText() {
    final i = widget.info;
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

  Future<void> _copy() async {
    final l10n = AppLocalizations.of(context);
    await Clipboard.setData(ClipboardData(text: _plainText()));
    if (!mounted) return;
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
              onTap: () => setState(() => _expanded = !_expanded),
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
                        widget.info.cidr,
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
                      onPressed: _copy,
                    ),
                    Icon(
                      _expanded
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
          AnimatedSize(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: _expanded
                ? Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _row(context, l10n.network, widget.info.networkAddress),
                        _row(context, l10n.broadcast, widget.info.broadcast),
                        _row(
                          context,
                          l10n.firstUsable,
                          widget.info.firstUsable,
                        ),
                        _row(context, l10n.lastUsable, widget.info.lastUsable),
                        _row(context, l10n.netmask, widget.info.netmask),
                        _row(context, l10n.wildcard, widget.info.wildcard),
                        _row(
                          context,
                          l10n.totalAddresses,
                          '${widget.info.totalAddresses}',

                          mono: false,
                        ),
                        _row(
                          context,
                          l10n.usableHosts,
                          '${widget.info.usableAddresses}',
                          mono: false,
                        ),
                        _row(
                          context,
                          l10n.ipClass,
                          widget.info.ipClass,
                          mono: false,
                        ),
                        _row(
                          context,
                          l10n.private,
                          widget.info.isPrivate ? '✔' : '✘',
                          valueColor: widget.info.isPrivate
                              ? scheme.primary
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

  Widget _row(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
    bool mono = true,
  }) {
    final t = Theme.of(context).textTheme;
    final ext = context.ext;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 148,
            child: Text(
              label,
              style: t.bodyMedium?.copyWith(color: ext.textMuted),
            ),
          ),
          Expanded(
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
      ),
    );
  }
}
