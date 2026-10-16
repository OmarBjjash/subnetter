import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subnetter/features/subnet/presentation/widgets/binary_ip_display.dart';

import '../../../../core/errors/app_error_l10n.dart';
import '../../../../core/responsive/adaptive_two_pane.dart';
import '../../../../core/responsive/app_breakpoints.dart';
import '../../../../core/responsive/responsive_metrics.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/cidr_cubit.dart';
import '../widgets/cidr_info_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/ip_octet_input.dart';
import '../widgets/mask_dropdown.dart';
import '../widgets/section_card.dart';

class CidrPage extends StatefulWidget {
  const CidrPage({super.key});
  @override
  State<CidrPage> createState() => _CidrPageState();
}

class _CidrPageState extends State<CidrPage> {
  late String _ip = '192.168.0.0';
  late int _prefix = 24;
  int _resetTick = 0;

  /// Owned by the page, not the card, so scrolling cannot collapse it.
  bool _infoExpanded = true;

  String get _cidr => '$_ip/$_prefix';
  void _sync() => context.read<CidrCubit>().setInput(_cidr);

  void _clear(CidrCubit cubit) {
    FocusScope.of(context).unfocus();
    setState(() {
      _ip = '192.168.0.0';
      _prefix = 24;
      _resetTick++;
      _infoExpanded = true;
    });
    cubit.reset();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<CidrCubit>();
    final sizeClass = context.sizeClass;
    final gutter = sizeClass.gutter;

    return BlocBuilder<CidrCubit, CidrState>(
      builder: (context, state) {
        final info = state.info;
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

        // Wide windows are split from the start: the details half is already
        // there, waiting for the first calculation. (Narrow windows fall back
        // to the form alone.)
        if (info == null) {
          return AdaptiveTwoPane(
            primary: formPane,
            secondary: _awaitingInfo(context, l10n, gutter),
          );
        }

        Widget infoCard() => CidrInfoCard(
          info: info,
          expanded: _infoExpanded,
          onExpansionChanged: (open) => setState(() => _infoExpanded = open),
        );

        return AdaptiveTwoPane(
          // Wide: the form owns the right half, the CIDR details the left half.
          primary: formPane,
          // Narrow: one scroll — form first, then the details.
          singlePane: ListView(
            padding: EdgeInsets.all(gutter),
            children: [
              ...inputSection,
              SizedBox(height: sizeClass.blockGap),
              Text(
                l10n.cidrInfo,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              infoCard(),
            ],
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
                child: Text(
                  l10n.cidrInfo,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(gutter, 0, gutter, gutter),
                  children: [infoCard()],
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
    CidrCubit cubit,
    CidrState state,
    WindowSizeClass sizeClass,
  ) {
    final t = Theme.of(context).textTheme;

    return [
      Text(l10n.cidrTitle, style: t.headlineSmall),
      const SizedBox(height: AppSpacing.xs),
      Text(
        l10n.cidrSubtitle,
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
              initialValue: _ip,
              resetSignal: _resetTick,
              onChanged: (v) {
                setState(() => _ip = v);
                _sync();
              },
            ),

            BinaryIpDisplay(ip: _ip), // <-- new
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

  /// The details half of the split before the first calculation.
  Widget _awaitingInfo(
    BuildContext context,
    AppLocalizations l10n,
    double gutter,
  ) {
    return Padding(
      padding: EdgeInsets.all(gutter),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.cidrInfo, style: Theme.of(context).textTheme.titleMedium),
          Expanded(
            child: EmptyState(
              icon: Icons.hub_outlined,
              message: l10n.cidrEmptyHint,
            ),
          ),
        ],
      ),
    );
  }
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
