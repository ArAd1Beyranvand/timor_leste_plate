import 'package:flutter/widgets.dart';

/// The colours of Timor-Leste plates, taken from the fitted reference photos
/// (`field`/`ink` of the platekit measurement), not from the article's
/// "black on white".
abstract final class TimorLesteColors {
  /// Field of the current plate, `______1.png` (the graphic samples FCFCFC).
  static const Color white = Color(0xFFFFFFFF);

  /// Characters and rim of the current plate; field of the historical plates.
  static const Color black = Color(0xFF000000);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0xFF5A5A5A);
}
