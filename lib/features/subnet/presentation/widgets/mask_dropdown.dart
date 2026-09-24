import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_components_theme.dart';
import '../../../../core/theme/app_spacing.dart';

class MaskDropdown extends StatefulWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final String label;

  const MaskDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Subnet mask',
  });

  @override
  State<MaskDropdown> createState() => _MaskDropdownState();
}

class _MaskDropdownState extends State<MaskDropdown> {
  late final ValueNotifier<int?> _valueListenable;

  static String maskFor(int prefix) {
    final m = prefix == 0 ? 0 : (0xFFFFFFFF << (32 - prefix)) & 0xFFFFFFFF;
    return '${(m >> 24) & 0xff}.${(m >> 16) & 0xff}.${(m >> 8) & 0xff}.${m & 0xff}';
  }

  @override
  void initState() {
    super.initState();
    _valueListenable = ValueNotifier<int?>(widget.value);
  }

  @override
  void didUpdateWidget(covariant MaskDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _valueListenable.value = widget.value;
    }
  }

  @override
  void dispose() {
    _valueListenable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final ext = context.ext;
    final comp = context.comp;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Text(
              widget.label,
              style: t.labelMedium?.copyWith(color: ext.textMuted),
            ),
          ),

        // LayoutBuilder captures the field width; menu width uses it.
        LayoutBuilder(
          builder: (context, constraints) {
            return DropdownButtonHideUnderline(
              child: DropdownButton2<int>(
                valueListenable: _valueListenable,
                isExpanded: true,
                hint: Text(
                  '/24',
                  style: t.bodyLarge?.copyWith(color: ext.textMuted),
                ),

                iconStyleData: IconStyleData(
                  icon: const Icon(Icons.expand_more_rounded),
                  iconSize: comp.dropdownButtonIconSize,
                  iconEnabledColor: ext.textMuted,
                  iconDisabledColor: ext.textMuted,
                ),

                buttonStyleData: ButtonStyleData(
                  padding: comp.dropdownButtonPadding,
                  height: comp.dropdownButtonHeight,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: comp.dropdownButtonRadius,
                    border: Border.all(color: ext.border),
                  ),
                ),

                dropdownStyleData: DropdownStyleData(
                  width: constraints.maxWidth, // ← matches the field
                  maxHeight: comp.dropdownMenuMaxHeight,
                  offset: comp.dropdownMenuOffset,
                  padding: comp.dropdownMenuPadding,
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: comp.dropdownMenuRadius,
                    border: Border.all(color: ext.border),
                    boxShadow: comp.dropdownMenuShadow,
                  ),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: Radius.circular(comp.dropdownScrollbarRadius),
                    thickness: WidgetStateProperty.all<double>(
                      comp.dropdownScrollbarThickness,
                    ),
                    thumbVisibility: WidgetStateProperty.all<bool>(true),
                    thumbColor: WidgetStateProperty.all(ext.border),
                  ),
                ),

                menuItemStyleData: MenuItemStyleData(
                  padding: comp.dropdownItemPadding,
                ),

                items: [
                  for (var p = 0; p <= 32; p++)
                    DropdownItem<int>(
                      value: p,
                      height: comp.dropdownItemHeight,
                      child: _MaskItem(
                        prefix: p,
                        mask: maskFor(p),
                        isSelected: p == widget.value,
                      ),
                    ),
                ],

                onChanged: (v) {
                  if (v != null) {
                    _valueListenable.value = v;
                    widget.onChanged(v);
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MaskItem extends StatelessWidget {
  final int prefix;
  final String mask;
  final bool isSelected;

  const _MaskItem({
    required this.prefix,
    required this.mask,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final comp = context.comp;
    final ext = context.ext;
    final t = Theme.of(context).textTheme;

    return Container(
      padding: comp.dropdownSelectedItemPadding,
      decoration: isSelected
          ? BoxDecoration(
              color: comp.dropdownSelectedItemBg,
              borderRadius: comp.dropdownSelectedItemRadius,
            )
          : null,
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: Text(
              '/$prefix',
              style: t.bodyMedium?.copyWith(
                fontFamily: 'monospace',
                fontWeight: isSelected
                    ? comp.dropdownSelectedItemWeight
                    : FontWeight.w600,
                color: isSelected ? comp.dropdownSelectedItemFg : null,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              mask,
              overflow: TextOverflow.ellipsis,
              style: t.bodySmall?.copyWith(
                color: isSelected ? comp.dropdownSelectedItemFg : ext.textMuted,
                fontFamily: 'monospace',
                fontWeight: isSelected
                    ? comp.dropdownSelectedItemWeight
                    : FontWeight.w400,
              ),
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check_rounded,
              size: 16,
              color: comp.dropdownSelectedItemFg,
            ),
        ],
      ),
    );
  }
}
