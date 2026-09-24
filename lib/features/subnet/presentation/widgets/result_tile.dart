import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';

class ResultTile extends StatelessWidget {
  final String label;
  final String value;
  final bool mono;
  const ResultTile({
    super.key, required this.label, required this.value, this.mono = true,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final ext = context.ext;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label,
              style: t.bodyMedium?.copyWith(color: ext.textMuted)),
          ),
          Expanded(
            child: Text(
              value,
              style: mono
                ? t.bodyMedium?.copyWith(fontFamily: 'monospace')
                : t.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}