import 'package:plate_core/plate_core.dart';

import 'timor_leste_colors.dart';

/// Timor-Leste as a `PlateCountry`. No plate carries a flag or country block
/// (`TLS` is a plain caption), so every spec sets `noPanel`; the colours are
/// the required placeholders. The national flag is not printed on any plate.
abstract final class TimorLesteCountry {
  // ignore: constant_identifier_names
  static const PlateCountry timor_leste = PlateCountry(
    code: 'tl',
    captionLines: <String>[],
    panelColor: TimorLesteColors.black,
    panelTextColor: TimorLesteColors.white,
  );
}
