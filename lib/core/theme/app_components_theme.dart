import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'app_colors.dart';

@immutable
class AppComponentsTheme extends ThemeExtension<AppComponentsTheme> {
  // ---------------- Dropdown ----------------
  final double dropdownButtonHeight;
  final EdgeInsets dropdownButtonPadding;
  final BorderRadius dropdownButtonRadius;
  final double dropdownButtonIconSize;

  final double dropdownMenuMaxHeight;
  final Offset dropdownMenuOffset;
  final EdgeInsets dropdownMenuPadding;
  final BorderRadius dropdownMenuRadius;
  final List<BoxShadow> dropdownMenuShadow;
  final double dropdownScrollbarThickness;
  final double dropdownScrollbarRadius;

  final double dropdownItemHeight;
  final EdgeInsets dropdownItemPadding;

  final Color dropdownSelectedItemBg;
  final Color dropdownSelectedItemFg;
  final FontWeight dropdownSelectedItemWeight;
  final BorderRadius dropdownSelectedItemRadius;
  final EdgeInsets dropdownSelectedItemPadding;

  // ---------------- Result / info cards ----------------
  final EdgeInsets cardHeaderPadding;
  final double cardHeaderIconSize;
  final double cardHeaderActionIconSize;
  final BorderRadius cardHeaderBadgeRadius;
  final EdgeInsets cardHeaderBadgePadding;
  final double cardHeaderBadgeOpacity;

  final EdgeInsets cardBodyPadding;
  final double cardRowLabelWidth;
  final EdgeInsets cardRowPadding;
  final Duration cardExpandDuration;
  final Curve cardExpandCurve;

  const AppComponentsTheme({
    required this.dropdownButtonHeight,
    required this.dropdownButtonPadding,
    required this.dropdownButtonRadius,
    required this.dropdownButtonIconSize,
    required this.dropdownMenuMaxHeight,
    required this.dropdownMenuOffset,
    required this.dropdownMenuPadding,
    required this.dropdownMenuRadius,
    required this.dropdownMenuShadow,
    required this.dropdownScrollbarThickness,
    required this.dropdownScrollbarRadius,
    required this.dropdownItemHeight,
    required this.dropdownItemPadding,
    required this.dropdownSelectedItemBg,
    required this.dropdownSelectedItemFg,
    required this.dropdownSelectedItemWeight,
    required this.dropdownSelectedItemRadius,
    required this.dropdownSelectedItemPadding,
    required this.cardHeaderPadding,
    required this.cardHeaderIconSize,
    required this.cardHeaderActionIconSize,
    required this.cardHeaderBadgeRadius,
    required this.cardHeaderBadgePadding,
    required this.cardHeaderBadgeOpacity,
    required this.cardBodyPadding,
    required this.cardRowLabelWidth,
    required this.cardRowPadding,
    required this.cardExpandDuration,
    required this.cardExpandCurve,
  });

  // ---------------- Factories ----------------
  factory AppComponentsTheme.light() => const AppComponentsTheme(
        dropdownButtonHeight: 52,
        dropdownButtonPadding:
            EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        dropdownButtonRadius: BorderRadius.all(Radius.circular(12)),
        dropdownButtonIconSize: 20,
        dropdownMenuMaxHeight: 320,
        dropdownMenuOffset: Offset(0, 4),
        dropdownMenuPadding: EdgeInsets.symmetric(vertical: 6),
        dropdownMenuRadius: BorderRadius.all(Radius.circular(12)),
        dropdownMenuShadow: [
          BoxShadow(color: Color(0x1A000000), blurRadius: 18, offset: Offset(0, 8)),
        ],
        dropdownScrollbarThickness: 6,
        dropdownScrollbarRadius: 6,
        dropdownItemHeight: 44,
        dropdownItemPadding: EdgeInsets.symmetric(horizontal: 8),
        dropdownSelectedItemBg: AppColors.lightPrimaryCont,
        dropdownSelectedItemFg: AppColors.lightPrimary,
        dropdownSelectedItemWeight: FontWeight.w700,
        dropdownSelectedItemRadius: BorderRadius.all(Radius.circular(8)),
        dropdownSelectedItemPadding:
            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        cardHeaderPadding:
            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        cardHeaderIconSize: 18,
        cardHeaderActionIconSize: 18,
        cardHeaderBadgeRadius: BorderRadius.all(Radius.circular(8)),
        cardHeaderBadgePadding:
            EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        cardHeaderBadgeOpacity: 0.16,
        cardBodyPadding: EdgeInsets.all(16),
        cardRowLabelWidth: 148,
        cardRowPadding: EdgeInsets.symmetric(vertical: 4),
        cardExpandDuration: Duration(milliseconds: 180),
        cardExpandCurve: Curves.easeOutCubic,
      );

  factory AppComponentsTheme.dark() => const AppComponentsTheme(
        dropdownButtonHeight: 52,
        dropdownButtonPadding:
            EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        dropdownButtonRadius: BorderRadius.all(Radius.circular(12)),
        dropdownButtonIconSize: 20,
        dropdownMenuMaxHeight: 320,
        dropdownMenuOffset: Offset(0, 4),
        dropdownMenuPadding: EdgeInsets.symmetric(vertical: 6),
        dropdownMenuRadius: BorderRadius.all(Radius.circular(12)),
        dropdownMenuShadow: [
          BoxShadow(color: Color(0x33000000), blurRadius: 18, offset: Offset(0, 8)),
        ],
        dropdownScrollbarThickness: 6,
        dropdownScrollbarRadius: 6,
        dropdownItemHeight: 44,
        dropdownItemPadding: EdgeInsets.symmetric(horizontal: 8),
        dropdownSelectedItemBg: AppColors.darkPrimaryCont,
        dropdownSelectedItemFg: AppColors.darkPrimary,
        dropdownSelectedItemWeight: FontWeight.w700,
        dropdownSelectedItemRadius: BorderRadius.all(Radius.circular(8)),
        dropdownSelectedItemPadding:
            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        cardHeaderPadding:
            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        cardHeaderIconSize: 18,
        cardHeaderActionIconSize: 18,
        cardHeaderBadgeRadius: BorderRadius.all(Radius.circular(8)),
        cardHeaderBadgePadding:
            EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        cardHeaderBadgeOpacity: 0.20,
        cardBodyPadding: EdgeInsets.all(16),
        cardRowLabelWidth: 148,
        cardRowPadding: EdgeInsets.symmetric(vertical: 4),
        cardExpandDuration: Duration(milliseconds: 180),
        cardExpandCurve: Curves.easeOutCubic,
      );

  // ---------------- Boilerplate ----------------
  @override
  AppComponentsTheme copyWith({
    double? dropdownButtonHeight,
    EdgeInsets? dropdownButtonPadding,
    BorderRadius? dropdownButtonRadius,
    double? dropdownButtonIconSize,
    double? dropdownMenuMaxHeight,
    Offset? dropdownMenuOffset,
    EdgeInsets? dropdownMenuPadding,
    BorderRadius? dropdownMenuRadius,
    List<BoxShadow>? dropdownMenuShadow,
    double? dropdownScrollbarThickness,
    double? dropdownScrollbarRadius,
    double? dropdownItemHeight,
    EdgeInsets? dropdownItemPadding,
    Color? dropdownSelectedItemBg,
    Color? dropdownSelectedItemFg,
    FontWeight? dropdownSelectedItemWeight,
    BorderRadius? dropdownSelectedItemRadius,
    EdgeInsets? dropdownSelectedItemPadding,
    EdgeInsets? cardHeaderPadding,
    double? cardHeaderIconSize,
    double? cardHeaderActionIconSize,
    BorderRadius? cardHeaderBadgeRadius,
    EdgeInsets? cardHeaderBadgePadding,
    double? cardHeaderBadgeOpacity,
    EdgeInsets? cardBodyPadding,
    double? cardRowLabelWidth,
    EdgeInsets? cardRowPadding,
    Duration? cardExpandDuration,
    Curve? cardExpandCurve,
  }) =>
      AppComponentsTheme(
        dropdownButtonHeight: dropdownButtonHeight ?? this.dropdownButtonHeight,
        dropdownButtonPadding: dropdownButtonPadding ?? this.dropdownButtonPadding,
        dropdownButtonRadius: dropdownButtonRadius ?? this.dropdownButtonRadius,
        dropdownButtonIconSize:
            dropdownButtonIconSize ?? this.dropdownButtonIconSize,
        dropdownMenuMaxHeight: dropdownMenuMaxHeight ?? this.dropdownMenuMaxHeight,
        dropdownMenuOffset: dropdownMenuOffset ?? this.dropdownMenuOffset,
        dropdownMenuPadding: dropdownMenuPadding ?? this.dropdownMenuPadding,
        dropdownMenuRadius: dropdownMenuRadius ?? this.dropdownMenuRadius,
        dropdownMenuShadow: dropdownMenuShadow ?? this.dropdownMenuShadow,
        dropdownScrollbarThickness:
            dropdownScrollbarThickness ?? this.dropdownScrollbarThickness,
        dropdownScrollbarRadius:
            dropdownScrollbarRadius ?? this.dropdownScrollbarRadius,
        dropdownItemHeight: dropdownItemHeight ?? this.dropdownItemHeight,
        dropdownItemPadding: dropdownItemPadding ?? this.dropdownItemPadding,
        dropdownSelectedItemBg:
            dropdownSelectedItemBg ?? this.dropdownSelectedItemBg,
        dropdownSelectedItemFg:
            dropdownSelectedItemFg ?? this.dropdownSelectedItemFg,
        dropdownSelectedItemWeight:
            dropdownSelectedItemWeight ?? this.dropdownSelectedItemWeight,
        dropdownSelectedItemRadius:
            dropdownSelectedItemRadius ?? this.dropdownSelectedItemRadius,
        dropdownSelectedItemPadding:
            dropdownSelectedItemPadding ?? this.dropdownSelectedItemPadding,
        cardHeaderPadding: cardHeaderPadding ?? this.cardHeaderPadding,
        cardHeaderIconSize: cardHeaderIconSize ?? this.cardHeaderIconSize,
        cardHeaderActionIconSize:
            cardHeaderActionIconSize ?? this.cardHeaderActionIconSize,
        cardHeaderBadgeRadius:
            cardHeaderBadgeRadius ?? this.cardHeaderBadgeRadius,
        cardHeaderBadgePadding:
            cardHeaderBadgePadding ?? this.cardHeaderBadgePadding,
        cardHeaderBadgeOpacity:
            cardHeaderBadgeOpacity ?? this.cardHeaderBadgeOpacity,
        cardBodyPadding: cardBodyPadding ?? this.cardBodyPadding,
        cardRowLabelWidth: cardRowLabelWidth ?? this.cardRowLabelWidth,
        cardRowPadding: cardRowPadding ?? this.cardRowPadding,
        cardExpandDuration: cardExpandDuration ?? this.cardExpandDuration,
        cardExpandCurve: cardExpandCurve ?? this.cardExpandCurve,
      );

  @override
  AppComponentsTheme lerp(
    ThemeExtension<AppComponentsTheme>? other,
    double t,
  ) {
    if (other is! AppComponentsTheme) return this;
    T pick<T>(T a, T b) => t < 0.5 ? a : b;
    return AppComponentsTheme(
      dropdownButtonHeight:
          lerpDouble(dropdownButtonHeight, other.dropdownButtonHeight, t)!,
      dropdownButtonPadding:
          pick(dropdownButtonPadding, other.dropdownButtonPadding),
      dropdownButtonRadius:
          pick(dropdownButtonRadius, other.dropdownButtonRadius),
      dropdownButtonIconSize:
          lerpDouble(dropdownButtonIconSize, other.dropdownButtonIconSize, t)!,
      dropdownMenuMaxHeight:
          lerpDouble(dropdownMenuMaxHeight, other.dropdownMenuMaxHeight, t)!,
      dropdownMenuOffset: pick(dropdownMenuOffset, other.dropdownMenuOffset),
      dropdownMenuPadding:
          pick(dropdownMenuPadding, other.dropdownMenuPadding),
      dropdownMenuRadius: pick(dropdownMenuRadius, other.dropdownMenuRadius),
      dropdownMenuShadow: pick(dropdownMenuShadow, other.dropdownMenuShadow),
      dropdownScrollbarThickness:
          lerpDouble(dropdownScrollbarThickness,
              other.dropdownScrollbarThickness, t)!,
      dropdownScrollbarRadius:
          lerpDouble(dropdownScrollbarRadius, other.dropdownScrollbarRadius, t)!,
      dropdownItemHeight:
          lerpDouble(dropdownItemHeight, other.dropdownItemHeight, t)!,
      dropdownItemPadding:
          pick(dropdownItemPadding, other.dropdownItemPadding),
      dropdownSelectedItemBg: Color.lerp(
          dropdownSelectedItemBg, other.dropdownSelectedItemBg, t)!,
      dropdownSelectedItemFg: Color.lerp(
          dropdownSelectedItemFg, other.dropdownSelectedItemFg, t)!,
      dropdownSelectedItemWeight:
          pick(dropdownSelectedItemWeight, other.dropdownSelectedItemWeight),
      dropdownSelectedItemRadius:
          pick(dropdownSelectedItemRadius, other.dropdownSelectedItemRadius),
      dropdownSelectedItemPadding:
          pick(dropdownSelectedItemPadding, other.dropdownSelectedItemPadding),
      cardHeaderPadding: pick(cardHeaderPadding, other.cardHeaderPadding),
      cardHeaderIconSize:
          lerpDouble(cardHeaderIconSize, other.cardHeaderIconSize, t)!,
      cardHeaderActionIconSize: lerpDouble(
          cardHeaderActionIconSize, other.cardHeaderActionIconSize, t)!,
      cardHeaderBadgeRadius:
          pick(cardHeaderBadgeRadius, other.cardHeaderBadgeRadius),
      cardHeaderBadgePadding:
          pick(cardHeaderBadgePadding, other.cardHeaderBadgePadding),
      cardHeaderBadgeOpacity:
          lerpDouble(cardHeaderBadgeOpacity, other.cardHeaderBadgeOpacity, t)!,
      cardBodyPadding: pick(cardBodyPadding, other.cardBodyPadding),
      cardRowLabelWidth:
          lerpDouble(cardRowLabelWidth, other.cardRowLabelWidth, t)!,
      cardRowPadding: pick(cardRowPadding, other.cardRowPadding),
      cardExpandDuration:
          pick(cardExpandDuration, other.cardExpandDuration),
      cardExpandCurve: pick(cardExpandCurve, other.cardExpandCurve),
    );
  }
}

extension AppComponentsX on BuildContext {
  AppComponentsTheme get comp =>
      Theme.of(this).extension<AppComponentsTheme>()!;
}