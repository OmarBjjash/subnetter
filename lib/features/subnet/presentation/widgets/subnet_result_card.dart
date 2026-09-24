import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:subnetter/l10n/app_localizations.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/subnet.dart';

class SubnetResultCard extends StatefulWidget {
  final int index;
  final Subnet subnet;
  final bool initiallyExpanded;

  const SubnetResultCard({
    super.key,
    required this.index,
    required this.subnet,
    this.initiallyExpanded = false,
  });

  @override
  State<SubnetResultCard> createState() => _SubnetResultCardState();
}

class _SubnetResultCardState extends State<SubnetResultCard> {
  late bool _expanded = widget.initiallyExpanded;

  String _plainText() {
    final s = widget.subnet;
    return 'Subnet #${widget.index}: ${s.cidr}\n'
        '  Network         : ${s.networkAddress}\n'
        '  Broadcast       : ${s.broadcast}\n'
        '  First usable    : ${s.firstUsable}\n'
        '  Last usable     : ${s.lastUsable}\n'
        '  Netmask         : ${s.netmask}\n'
        '  Wildcard        : ${s.wildcard}\n'
        '  Total addresses : ${s.totalAddresses}\n'
        '  Usable hosts    : ${s.usableHosts}\n';
  }

  Future<void> _copy() async {
    final l10n = AppLocalizations.of(context);
    await Clipboard.setData(ClipboardData(text: _plainText()));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.subNetCopied),
          duration: const Duration(seconds: 2),
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
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.onPrimary.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusSm,
                        ),
                      ),
                      child: Text(
                        '#${widget.index}',
                        style: t.labelMedium?.copyWith(
                          color: scheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        widget.subnet.cidr,
                        style: t.titleMedium?.copyWith(
                          color: scheme.onPrimary,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.copySubnetInfo,
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
                        _row(
                          context,
                          l10n.network,
                          widget.subnet.networkAddress,
                        ),
                        _row(context, l10n.broadcast, widget.subnet.broadcast),
                        _row(
                          context,
                          l10n.firstUsable,
                          widget.subnet.firstUsable,
                        ),
                        _row(
                          context,
                          l10n.lastUsable,
                          widget.subnet.lastUsable,
                        ),
                        _row(context, l10n.netmask, widget.subnet.netmask),
                        _row(context, l10n.wildcard, widget.subnet.wildcard),
                        _row(
                          context,
                          l10n.totalAddresses,
                          '${widget.subnet.totalAddresses}',
                          mono: false,
                        ),
                        _row(
                          context,
                          l10n.usableHosts,
                          '${widget.subnet.usableHosts}',
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
