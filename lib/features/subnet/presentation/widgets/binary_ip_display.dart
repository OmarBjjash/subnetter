import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/ip_utils.dart';

class BinaryIpDisplay extends StatelessWidget {
  final String ip;
  final bool compact;

  const BinaryIpDisplay({super.key, required this.ip, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final octets = Ipv4.ipToBinaryOctets(ip);
    final ext = context.ext;

    final style = AppTypography.monoSmall.copyWith(color: ext.textMuted);
    final dotStyle = style.copyWith(fontWeight: FontWeight.w600);

    return Padding(
      padding: EdgeInsets.only(top: compact ? AppSpacing.xs : AppSpacing.sm),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            for (var i = 0; i < 4; i++) ...[
              Expanded(
                key: ValueKey('bin_field_$i'),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    octets[i],
                    textAlign: TextAlign.center,
                    style: style,
                  ),
                ),
              ),
              if (i < 3)
                Padding(
                  key: ValueKey('bin_dot_$i'),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                  ),
                  child: Text('.', style: dotStyle),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
