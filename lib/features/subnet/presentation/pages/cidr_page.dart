import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/cidr_cubit.dart';
import '../widgets/cidr_info_card.dart';
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

  String get _cidr => '$_ip/$_prefix';
  void _sync() => context.read<CidrCubit>().setInput(_cidr);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<CidrCubit>();

    return BlocBuilder<CidrCubit, CidrState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              l10n.cidrTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.cidrSubtitle,
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
                    'IP address',
                    style: Theme.of(context).textTheme.labelMedium
                        ?.copyWith(color: context.ext.textMuted),
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  IpOctetInput(
                    initialValue: _ip,
                    onChanged: (v) {
                      setState(() => _ip = v);
                      _sync();
                    },
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  MaskDropdown(
                    value: _prefix,
                    label: 'Subnet mask  (/0 – /32)',
                    onChanged: (p) {
                      setState(() => _prefix = p);
                      _sync();
                    },
                  ),

                  const SizedBox(height: AppSpacing.lg),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton.icon(
                      onPressed: () {
                        FocusScope.of(context).unfocus(); // dismiss fields
                        cubit.calculate();
                      },
                      icon: const Icon(Icons.calculate_outlined, size: 18),
                      label: Text(l10n.calculate),
                    ),
                  ),

                  if (state.error != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    _ErrorBanner(message: state.error!),
                  ],
                ],
              ),
            ),

            if (state.info != null) ...[
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.cidrInfo,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              CidrInfoCard(info: state.info!),
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
