import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subnetter/features/subnet/presentation/widgets/binary_ip_display.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/subnet_result.dart';
import '../cubit/subnet_cubit.dart';
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

  @override
  void dispose() {
    _countCtrl.dispose();
    super.dispose();
  }

  String get _cidr => '$_ip/$_prefix';
  void _sync() => context.read<SubnetCubit>().setCidr(_cidr);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<SubnetCubit>();

    return BlocBuilder<SubnetCubit, SubnetState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              l10n.subnetTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.subnetSubtitle,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: context.ext.textMuted),
            ),
            const SizedBox(height: AppSpacing.lg),

            SectionCard(
              title: l10n.input,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.ipAddress,
                    style: Theme.of(context).textTheme.labelMedium
                        ?.copyWith(color: context.ext.textMuted),
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

                  TextField(
                    controller: _countCtrl,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: l10n.numberOfSubnets,
                    ),
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
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _ip = '192.168.0.0';
                              _prefix = 24;
                              _countCtrl.text = '3';
                              _resetTick++;
                            });
                            cubit.reset();
                          },
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
                    _ErrorBanner(message: state.error!),
                  ],
                ],
              ),
            ),

            if (state.result != null) ...[
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.results,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    '${state.result!.subnets.length}',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(color: context.ext.textMuted),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              for (var i = 0; i < state.result!.subnets.length; i++)
                SubnetResultCard(
                  index: i + 1,
                  subnet: state.result!.subnets[i],
                  initiallyExpanded: i == 0,
                ),
              if (state.result!.note != null)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.sm),
                  child: Text(
                    state.result!.note!,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: context.ext.textMuted),
                  ),
                ),
            ],
          ],
        );
      },
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
