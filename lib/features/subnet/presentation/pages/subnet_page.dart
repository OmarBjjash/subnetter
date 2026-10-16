import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subnetter/features/subnet/presentation/widgets/binary_ip_display.dart';

import '../../../../core/errors/app_error_l10n.dart';
import '../../../../core/responsive/adaptive_two_pane.dart';
import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/responsive/responsive_metrics.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/subnet_result.dart';
import '../cubit/subnet_cubit.dart';
import '../widgets/empty_state.dart';
import '../widgets/ip_octet_input.dart';
import '../widgets/mask_dropdown.dart';
import '../widgets/section_card.dart';
import '../widgets/subnet_result_card.dart';

class SubnetPage extends StatefulWidget {
  const SubnetPage({super.key});
  @override
  State<SubnetPage> createState() => _SubnetPageState();
}

class _SubnetPageState extends State<SubnetPage> {
  late String _ip = '192.168.0.0';
  late int _prefix = 24;
  int _resetTick = 0;
  final _countCtrl = TextEditingController(text: '3');

  /// Which result cards are open. This lives here, not inside each card, so a
  /// card that scrolls out of the viewport and is rebuilt comes back expanded
  /// instead of collapsing to its header.
  final Set<int> _expanded = {0};

  @override
  void dispose() {
    _countCtrl.dispose();
    super.dispose();
  }

  String get _cidr => '$_ip/$_prefix';
  void _sync() => context.read<SubnetCubit>().setCidr(_cidr);

  void _setExpanded(int index, bool open) {
    setState(() {
      if (open) {
        _expanded.add(index);
      } else {
        _expanded.remove(index);
      }
    });
  }

  void _clear(SubnetCubit cubit) {
    FocusScope.of(context).unfocus();
    setState(() {
      _ip = '192.168.0.0';
      _prefix = 24;
      _countCtrl.text = '3';
      _resetTick++;
      _expanded
        ..clear()
        ..add(0);
    });
    cubit.reset();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<SubnetCubit>();
    final sizeClass = context.sizeClass;
    final gutter = sizeClass.gutter;

    return BlocBuilder<SubnetCubit, SubnetState>(
      builder: (context, state) {
        final result = state.result;
        final inputSection = _inputSection(
          context,
          l10n,
          cubit,
          state,
          sizeClass,
        );

        final formPane = ListView(
          padding: EdgeInsets.all(gutter),
          children: inputSection,
        );

        if (result == null) {
          // Wide windows are split from the start: the results half is already
          // there, waiting for the first calculation. (Narrow windows fall back
          // to the form alone.)
          return AdaptiveTwoPane(
            primary: formPane,
            secondary: _awaitingResults(context, l10n, gutter),
          );
        }

        final note = result.note;
        final header = _resultsHeader(
          context,
          l10n,
          result.subnets.length,
          onCopy: (format) => _copyAll(context, result, format),
        );

        Widget cardAt(int index) => SubnetResultCard(
          index: index + 1,
          subnet: result.subnets[index],
          expanded: _expanded.contains(index),
          onExpansionChanged: (open) => _setExpanded(index, open),
        );

        return AdaptiveTwoPane(
          // Wide: the form owns the right half, the result cards the left half.
          primary: formPane,
          // Narrow: one scroll — form first, then the results.
          singlePane: ListView.builder(
            padding: EdgeInsets.all(gutter),
            itemCount: 1 + result.subnets.length + (note == null ? 0 : 1),
            itemBuilder: (context, i) {
              if (i == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...inputSection,
                    SizedBox(height: sizeClass.blockGap),
                    header,
                    const SizedBox(height: AppSpacing.md),
                  ],
                );
              }
              if (i <= result.subnets.length) return cardAt(i - 1);
              return _note(context, note!);
            },
          ),
          secondary: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  gutter,
                  gutter,
                  gutter,
                  AppSpacing.md,
                ),
                child: header,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(gutter, 0, gutter, gutter),
                  itemCount: result.subnets.length + (note == null ? 0 : 1),
                  itemBuilder: (context, i) => i < result.subnets.length
                      ? cardAt(i)
                      : _note(context, note!),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _inputSection(
    BuildContext context,
    AppLocalizations l10n,
    SubnetCubit cubit,
    SubnetState state,
    WindowSizeClass sizeClass,
  ) {
    final t = Theme.of(context).textTheme;

    return [
      Text(l10n.subnetTitle, style: t.headlineSmall),
      const SizedBox(height: AppSpacing.xs),
      Text(
        l10n.subnetSubtitle,
        style: t.bodyMedium?.copyWith(color: context.ext.textMuted),
      ),
      SizedBox(height: sizeClass.blockGap),

      SectionCard(
        title: l10n.input,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.ipAddress,
              style: t.labelMedium?.copyWith(color: context.ext.textMuted),
            ),
            const SizedBox(height: AppSpacing.sm),

            IpOctetInput(
              resetSignal: _resetTick,
              initialValue: _ip,
              onChanged: (v) {
                setState(() => _ip = v);
                _sync();
              },
            ),
            BinaryIpDisplay(ip: _ip),
            const SizedBox(height: AppSpacing.lg),

            const SizedBox(height: AppSpacing.lg),

            MaskDropdown(
              value: _prefix,
              label: '${l10n.subnetMask}  (/0 – /32)',
              onChanged: (p) {
                setState(() => _prefix = p);
                _sync();
              },
            ),

            const SizedBox(height: AppSpacing.lg),

            TextField(
              controller: _countCtrl,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: l10n.numberOfSubnets),
              onChanged: (v) => cubit.setCount(int.tryParse(v) ?? 1),
            ),

            const SizedBox(height: AppSpacing.lg),

            SegmentedButton<SubnetMode>(
              segments: [
                ButtonSegment(
                  value: SubnetMode.equalSize,
                  icon: const Icon(Icons.grid_view_rounded),
                  label: Text(l10n.modeEqual),
                ),
                ButtonSegment(
                  value: SubnetMode.vlsm,
                  icon: const Icon(Icons.account_tree_outlined),
                  label: Text(l10n.modeVlsm),
                ),
              ],
              selected: {state.mode},
              onSelectionChanged: (v) => cubit.setMode(v.first),
              showSelectedIcon: false,
            ),

            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _clear(cubit),
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: Text(l10n.clear),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      cubit.calculate();
                    },
                    icon: const Icon(Icons.calculate_outlined, size: 18),
                    label: Text(l10n.calculate),
                  ),
                ),
              ],
            ),

            if (state.error != null) ...[
              const SizedBox(height: AppSpacing.md),
              _ErrorBanner(message: state.error!.message(l10n)),
            ],
          ],
        ),
      ),
    ];
  }

  Widget _resultsHeader(
    BuildContext context,
    AppLocalizations l10n,
    int count, {
    ValueChanged<_CopyFormat>? onCopy,
  }) {
    final t = Theme.of(context).textTheme;
    final muted = context.ext.textMuted;
    return Row(
      children: [
        Expanded(child: Text(l10n.results, style: t.titleMedium)),
        Text(
          '$count',
          style: t.titleMedium?.copyWith(color: context.ext.textMuted),
        ),
        if (onCopy != null) ...[
          const SizedBox(width: AppSpacing.sm),
          PopupMenuButton<_CopyFormat>(
            tooltip: l10n.copyAllSubnets,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            position: PopupMenuPosition.under,
            icon: const Icon(Icons.copy_all_rounded, size: 20),
            onSelected: onCopy,
            constraints: const BoxConstraints(minWidth: 280, maxWidth: 340),
            itemBuilder: (menuContext) => [
              PopupMenuItem(
                value: _CopyFormat.blocks,
                height: 60,
                child: Row(
                  children: [
                    const Icon(Icons.notes_rounded, size: 20),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.copyFormatBlocks, style: t.bodyMedium),
                          Text(
                            l10n.copyFormatBlocksHint,
                            style: t.bodySmall?.copyWith(color: muted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: _CopyFormat.markdown,
                height: 60,
                child: Row(
                  children: [
                    const Icon(Icons.table_chart_outlined, size: 20),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.copyFormatMarkdown, style: t.bodyMedium),
                          Text(
                            l10n.copyFormatMarkdownHint,
                            style: t.bodySmall?.copyWith(color: muted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  /// Text dump of every subnet as aligned label/value blocks, so it stays
  /// readable when pasted into a chat or a plain-text file.
  static String _exportBlocks(SubnetResult result) {
    final b = StringBuffer()
      ..writeln('${result.inputCidr} → ${result.subnets.length} subnets')
      ..writeln();

    for (var i = 0; i < result.subnets.length; i++) {
      final s = result.subnets[i];
      b
        ..writeln('#${i + 1}  ${s.cidr}')
        ..writeln('    Network         ${s.networkAddress}')
        ..writeln('    Broadcast       ${s.broadcast}')
        ..writeln('    First usable    ${s.firstUsable}')
        ..writeln('    Last usable     ${s.lastUsable}')
        ..writeln('    Netmask         ${s.netmask}')
        ..writeln('    Wildcard        ${s.wildcard}')
        ..writeln('    Total addresses ${s.totalAddresses}')
        ..writeln('    Usable hosts    ${s.usableHosts}')
        ..writeln('--- ========== ---');
      if (i < result.subnets.length - 1) b.writeln();
    }

    final note = result.note;
    if (note != null) {
      b
        ..writeln()
        ..writeln(note);
    }

    return b.toString().trimRight();
  }

  /// The same data as a GitHub-flavored Markdown table, which renders as a real
  /// table in Slack, Notion, GitHub, etc.
  static String _exportMarkdown(SubnetResult result) {
    final b = StringBuffer()
      ..writeln('**${result.inputCidr} → ${result.subnets.length} subnets**')
      ..writeln()
      ..writeln(
        '| # | subnet | Netmask | first IP - last IP | Broadcast | Hosts |',
      )
      ..writeln('| :---: | --- | --- | --- | --- | --- |');

    for (var i = 0; i < result.subnets.length; i++) {
      final s = result.subnets[i];
      b.writeln(
        '| ${i + 1} | ${s.cidr} | ${s.netmask} '
        '| ${s.firstUsable} - ${s.lastUsable} '
        '| ${s.broadcast} | ${s.usableHosts} |',
      );
    }

    final note = result.note;
    if (note != null) {
      b
        ..writeln()
        ..writeln(note);
    }

    return b.toString().trimRight();
  }

  /// Copies the whole result set in [format].
  Future<void> _copyAll(
    BuildContext context,
    SubnetResult result,
    _CopyFormat format,
  ) async {
    final l10n = AppLocalizations.of(context);

    final text = switch (format) {
      _CopyFormat.blocks => _exportBlocks(result),
      _CopyFormat.markdown => _exportMarkdown(result),
    };

    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.subnetsCopied),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  /// The results half of the split before the first calculation.
  Widget _awaitingResults(
    BuildContext context,
    AppLocalizations l10n,
    double gutter,
  ) {
    return Padding(
      padding: EdgeInsets.all(gutter),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _resultsHeader(context, l10n, 0),
          Expanded(
            child: EmptyState(
              icon: Icons.calculate_outlined,
              message: l10n.resultsEmptyHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _note(BuildContext context, String note) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.sm),
    child: Text(
      note,
      style: Theme.of(context).textTheme.bodySmall
          ?.copyWith(color: context.ext.textMuted),
    ),
  );
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    final danger = context.ext.danger;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: danger.withValues(alpha: 0.1),
        border: Border.all(color: danger.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: danger, size: 18),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: danger),
            ),
          ),
        ],
      ),
    );
  }
}

/// Text flavours offered by the "copy all subnets" chooser.
enum _CopyFormat { blocks, markdown }
