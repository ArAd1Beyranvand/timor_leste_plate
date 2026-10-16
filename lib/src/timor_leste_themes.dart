import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'timor_leste_colors.dart';

abstract final class TimorLesteThemes {
  static PlateTheme _field({
    required Color field,
    required Color ink,
    required Color inactive,
    required Color rim,
    required double borderWidthRatio,
    required double plateRadiusRatio,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: rim,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: borderWidthRatio,
    plateRadiusRatio: plateRadiusRatio,
    activeColor: ink,
    inactiveColor: inactive,
    alertColor: const Color(0xFFD32F2F),
  );

  /// Heavy black rim (~5 mm of 134, corners ~8 mm).
  static final PlateTheme private = _field(
    field: TimorLesteColors.white,
    ink: TimorLesteColors.black,
    inactive: TimorLesteColors.inactiveOnLight,
    rim: TimorLesteColors.black,
    borderWidthRatio: 0.035,
    plateRadiusRatio: 0.06,
  );

  /// Same livery as [private], named so each spec has its own theme.
  static final PlateTheme government = private;

  /// Thin white rim.
  static final PlateTheme indonesian = _field(
    field: TimorLesteColors.black,
    ink: TimorLesteColors.white,
    inactive: TimorLesteColors.inactiveOnDark,
    rim: TimorLesteColors.white,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0.03,
  );

  /// Frameless: the rim is the field colour.
  static final PlateTheme portuguese = _field(
    field: TimorLesteColors.black,
    ink: TimorLesteColors.white,
    inactive: TimorLesteColors.inactiveOnDark,
    rim: TimorLesteColors.black,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0,
  );
}
