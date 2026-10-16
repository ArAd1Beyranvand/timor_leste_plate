import 'package:plate_core/plate_core.dart';

import 'timor_leste_colors.dart';

/// No plate carries a flag or country block (`TLS` is a plain caption), so
/// every spec sets `noPanel`; the colours are required placeholders.
abstract final class TimorLesteCountry {
  // ignore: constant_identifier_names
  static const PlateCountry timor_leste = PlateCountry(
    code: 'tl',
    captionLines: <String>[],
    panelColor: TimorLesteColors.black,
    panelTextColor: TimorLesteColors.white,
  );
}
