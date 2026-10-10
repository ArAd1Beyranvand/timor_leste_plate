import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'timor_leste_colors.dart';

/// The Timor-Leste liveries: one ink on one field, so one helper.
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

  /// Black on white with a heavy black rim (~5 mm of 134, corners ~8 mm):
  /// private and government plates, measured on `______1.png`.
  static final PlateTheme private = _field(
    field: TimorLesteColors.white,
    ink: TimorLesteColors.black,
    inactive: TimorLesteColors.inactiveOnLight,
    rim: TimorLesteColors.black,
    borderWidthRatio: 0.035,
    plateRadiusRatio: 0.06,
  );

  /// Same livery as [private]; named so the government plate is wired to its
  /// own theme.
  static final PlateTheme government = private;

  /// White on black with a thin white rim: the Indonesian-era `DF` plate.
  static final PlateTheme indonesian = _field(
    field: TimorLesteColors.black,
    ink: TimorLesteColors.white,
    inactive: TimorLesteColors.inactiveOnDark,
    rim: TimorLesteColors.white,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0.03,
  );

  /// White on black, frameless (the rim is the field colour): Portuguese
  /// Timor `T` / `TP` plates.
  static final PlateTheme portuguese = _field(
    field: TimorLesteColors.black,
    ink: TimorLesteColors.white,
    inactive: TimorLesteColors.inactiveOnDark,
    rim: TimorLesteColors.black,
    borderWidthRatio: 0.02,
    plateRadiusRatio: 0,
  );
}
