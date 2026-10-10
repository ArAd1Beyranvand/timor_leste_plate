import 'package:plate_core/plate_core.dart';

import 'timor_leste_colors.dart';
import 'timor_leste_country.dart';
import 'package:plate_alphabet/plate_alphabet.dart';

/// Where the ink sits, in plate coordinates. Reference plates were flattened
/// to the article's 372×134 mm by platekit and the ink projected onto each
/// axis.
///
/// **Current plate** (`______1.png`, `East_Timor_license_plate_graphic.png`):
/// digit ink y 18.2..99 / 19.5..94.8 (centre ~58), x 17.8..283.5; digit
/// centres 28.4, 77.4 | diamond 127.6 | 170, 219.6, 271.8, i.e. a pitch of ~50
/// and a 43-wide diamond cell. The ink is left of centre — the right 90 mm is
/// the room a government `G` takes. `TLS` ink y 105.2..122.8 (17.6 tall), x
/// 159.8..217.8, centred on the plate. The four screw dots at y 9..15 are
/// not drawn.
///
/// **Indonesian plate** (`..._under_Indonesian_Occupation.png`, flattened at
/// 372×128 and laid on 372×134): expiry ink y 9.2..29.5, x 140.5..231.5;
/// the box under it has its bottom edge at y 33.2..36.5 and spans
/// x 14.8..357; main row ink y 48.2..114.8, x 16.8..355.5 (`DF`, `1202`, `AA`
/// at ~35 pitch with ~28 gaps).
///
/// **Portuguese Timor** (`orig_Portuguese_Timor_vehicle_registration_plates.jpg`,
/// an artwork of three plates, measured by hand on the 543×511 original; the
/// article gives no size, so the canvases are the artwork's proportions
/// scaled by 0.92): the long plates are 543×120 (ar 4.5) with ink y 20..108
/// of the plate and `T-12-34` x 92..472; the stacked plate is 326×231 with
/// `T` ink y 15..105 and `12-34` y 135..218, x 122..402.
///
/// **Under-height ink, accepted.** The reference digits are a condensed face
/// 75–80 mm tall; a slot as tall as the plate allows prints ~55% of its
/// height as ink, and the engine shrinks a glyph that is wider than its
/// slot. Ink is therefore ~65–85% of reference; `plate_core` is unchanged.
abstract final class _Layout {
  // Current plate.
  static const double width = 372;
  static const double height = 134;
  static const double digitTop = 8;
  static const double digitHeight = 100;
  static const double digitPitch = 49.5;
  static const double firstLeft = 3.5;
  static const double secondLeft = 146.5;
  static const double suffixLeft = 297;
  static const double diamondCentreX = 127.6;
  static const double diamondCentreY = 57;
  static const double diamondGlyph = 26;
  static const double tlsCentreX = 188.8;
  static const double tlsCentreY = 114;
  static const double tlsGlyph = 32;

  // Indonesian plate.
  static const double idPitch = 35.5;
  static const double idGap = 28;
  static const double idTop = 31.5;
  static const double idHeight = 100;
  static const double idExpiryLeft = 137;
  static const double idExpiryPitch = 21;
  static const double idExpiryDot = 14;
  static const double idExpiryTop = 0.9;
  static const double idExpiryHeight = 37;
  static const double idBoxLeft = 14.8;
  static const double idBoxRight = 357;
  static const double idBoxTop = 3;
  static const double idBoxBottom = 36.5;
  static const double idBoxLine = 3.3;

  // Portuguese Timor.
  static const double ptWidth = 500;
  static const double ptHeight = 111;
  static const double ptTop = 3;
  static const double ptSlot = 105;
  static const double ptPitch = 54;
  static const double ptDash = 34;
  static const double ptStackWidth = 300;
  static const double ptStackHeight = 212;
  static const double ptStackTop = 7;
  static const double ptStackSecondTop = 112;
  static const double ptStackSlot = 94;
  static const double ptStackPitch = 52;
  static const double ptStackDash = 38;
}

/// Timor-Leste's plate designs.
///
/// * [private] — `NN·NNN` and [government] — `NN·NNNG`, black on white with
///   `TLS` beneath; the article's "four digits and G" contradicts its own
///   example `05-204G`, so the example is followed.
/// * [indonesian] — `04·85` expiry above `DF 1202 AA`, white on black, in use
///   1976–1999. Not issued any more; kept as history.
/// * [portuguese] — `T-12-34` / `TP-12-34`, and [portugueseStacked] with the
///   `T` above `12-34`, white on black. Historical.
///
/// Text groups: [private]/[government] `first` (2), `second` (3) and, on
/// [government], `suffix`; [indonesian] `expiry`, `prefix`, `number`, `suffix`;
/// the Portuguese plates `prefix`, `first`, `second`.
abstract final class TimorLestePlates {
  static final PlateSpec private = _current(government: false);
  static final PlateSpec government = _current(government: true);

  static final Map<int, PlateSpec> _indonesian = <int, PlateSpec>{};
  static final Map<int, PlateSpec> _portuguese = <int, PlateSpec>{};

  /// The Indonesian plate with [digits] (1–4) in the number and [suffix]
  /// (0–2) letters after it.
  static PlateSpec indonesian({int digits = 4, int suffix = 2}) {
    if (digits < 1 || digits > 4 || suffix < 0 || suffix > 2) {
      throw ArgumentError('Indonesian plate: 1–4 digits, 0–2 suffix letters.');
    }
    return _indonesian[digits * 10 + suffix] ??= _indonesianSpec(
      digits,
      suffix,
    );
  }

  /// The one-row Portuguese Timor plate with a [prefix] of 1 (`T`) or 2
  /// (`TP`) letters.
  static PlateSpec portuguese({int prefix = 1}) {
    if (prefix != 1 && prefix != 2) {
      throw ArgumentError('Portuguese Timor prefix is T or TP.');
    }
    return _portuguese[prefix] ??= _portugueseSpec(prefix);
  }

  static final PlateSpec portugueseStacked = _stackedSpec();

  static PlateSpec _current({required bool government}) {
    final double suffixTop = _Layout.digitTop;
    return PlateSpec(
      id: government ? 'tl.government' : 'tl.private',
      country: TimorLesteCountry.timor_leste,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
      slots: <PlateSlot>[
        ...plateRegister(
          alphabet: TimorLesteAlphabets.digits,
          count: 2,
          left: _Layout.firstLeft,
          top: _Layout.digitTop,
          width: _Layout.digitPitch,
          height: _Layout.digitHeight,
        ),
        ...plateRegister(
          alphabet: TimorLesteAlphabets.digits,
          count: 3,
          left: _Layout.secondLeft,
          top: _Layout.digitTop,
          width: _Layout.digitPitch,
          height: _Layout.digitHeight,
        ),
        if (government)
          PlateSlot(
            alphabet: TimorLesteAlphabets.letters,
            box: PlateBox(
              _Layout.suffixLeft,
              suffixTop,
              _Layout.digitPitch,
              _Layout.digitHeight,
            ),
          ),
      ],
      labels: <PlateLabel>[
        PlateLabel(
          text: '◆',
          box: PlateBox(
            _Layout.diamondCentreX - 20,
            _Layout.diamondCentreY - _Layout.diamondGlyph / 2,
            40,
            _Layout.diamondGlyph,
          ),
          glyphHeight: _Layout.diamondGlyph,
        ),
        PlateLabel(
          text: 'T L S',
          box: PlateBox(
            _Layout.tlsCentreX - 35,
            _Layout.tlsCentreY - _Layout.tlsGlyph / 2,
            70,
            _Layout.tlsGlyph,
          ),
          glyphHeight: _Layout.tlsGlyph,
        ),
      ],
      textGroups: <PlateTextGroup>[
        const PlateTextGroup(<int>[0, 1], key: 'first'),
        const PlateTextGroup(<int>[2, 3, 4], key: 'second'),
        if (government) const PlateTextGroup(<int>[5], key: 'suffix'),
      ],
    );
  }

  static PlateSpec _indonesianSpec(int digits, int suffix) {
    final int cells = 2 + digits + suffix;
    final int gaps = suffix > 0 ? 2 : 1;
    final double content = cells * _Layout.idPitch + gaps * _Layout.idGap;
    final double left = (_Layout.width - content) / 2;
    final double numberLeft = left + 2 * _Layout.idPitch + _Layout.idGap;
    final double suffixLeft =
        numberLeft + digits * _Layout.idPitch + _Layout.idGap;
    final double dotLeft = _Layout.idExpiryLeft + 2 * _Layout.idExpiryPitch;
    final double secondLeft = _Layout.idExpiryLeft + 3 * _Layout.idExpiryPitch;
    const double box = _Layout.idBoxLine;
    return PlateSpec(
      id: 'tl.indonesian.$digits$suffix',
      country: TimorLesteCountry.timor_leste,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
      bands: <PlateBand>[
        // The expiry box is a white outline: a white pill with the field
        // laid back inside it. It floats clear of the plate edge.
        const PlateBand(
          box: PlateBox(
            _Layout.idBoxLeft,
            _Layout.idBoxTop,
            _Layout.idBoxRight - _Layout.idBoxLeft,
            _Layout.idBoxBottom - _Layout.idBoxTop,
          ),
          color: TimorLesteColors.white,
          topCornerRadius: 8,
          bottomCornerRadius: 8,
        ),
        const PlateBand(
          box: PlateBox(
            _Layout.idBoxLeft + box,
            _Layout.idBoxTop + box,
            _Layout.idBoxRight - _Layout.idBoxLeft - 2 * box,
            _Layout.idBoxBottom - _Layout.idBoxTop - 2 * box,
          ),
          color: TimorLesteColors.black,
          topCornerRadius: 5,
          bottomCornerRadius: 5,
        ),
      ],
      slots: <PlateSlot>[
        ...plateRegister(
          alphabet: TimorLesteAlphabets.digits,
          count: 4,
          left: _Layout.idExpiryLeft,
          top: _Layout.idExpiryTop,
          width: _Layout.idExpiryPitch,
          height: _Layout.idExpiryHeight,
        ),
        ...plateRegister(
          alphabet: TimorLesteAlphabets.letters,
          count: 2,
          left: left,
          top: _Layout.idTop,
          width: _Layout.idPitch,
          height: _Layout.idHeight,
        ),
        ...plateRegister(
          alphabet: TimorLesteAlphabets.digits,
          count: digits,
          left: numberLeft,
          top: _Layout.idTop,
          width: _Layout.idPitch,
          height: _Layout.idHeight,
        ),
        ...plateRegister(
          alphabet: TimorLesteAlphabets.letters,
          count: suffix,
          left: suffixLeft,
          top: _Layout.idTop,
          width: _Layout.idPitch,
          height: _Layout.idHeight,
        ),
      ],
      labels: <PlateLabel>[
        PlateLabel(
          text: '·',
          box: PlateBox(
            dotLeft,
            _Layout.idExpiryTop,
            _Layout.idExpiryDot,
            _Layout.idExpiryHeight,
          ),
          glyphHeight: _Layout.idExpiryHeight,
        ),
      ],
      textGroups: <PlateTextGroup>[
        const PlateTextGroup(<int>[0, 1, 2, 3], key: 'expiry'),
        const PlateTextGroup(<int>[4, 5], key: 'prefix'),
        PlateTextGroup(<int>[
          for (int i = 0; i < digits; i++) 6 + i,
        ], key: 'number'),
        if (suffix > 0)
          PlateTextGroup(<int>[
            for (int i = 0; i < suffix; i++) 6 + digits + i,
          ], key: 'suffix'),
      ],
    );
  }

  static PlateLabel _dash(double left, double top, double width, double slot) =>
      PlateLabel(
        text: '-',
        box: PlateBox(left, top, width, slot),
        glyphHeight: slot,
      );

  static PlateSpec _portugueseSpec(int prefix) {
    final double content =
        prefix * _Layout.ptPitch + 4 * _Layout.ptPitch + 2 * _Layout.ptDash;
    final double left = (_Layout.ptWidth - content) / 2;
    final double dash1 = left + prefix * _Layout.ptPitch;
    final double firstLeft = dash1 + _Layout.ptDash;
    final double dash2 = firstLeft + 2 * _Layout.ptPitch;
    final double secondLeft = dash2 + _Layout.ptDash;
    return PlateSpec(
      id: 'tl.portuguese.$prefix',
      country: TimorLesteCountry.timor_leste,
      canvasWidth: _Layout.ptWidth,
      canvasHeight: _Layout.ptHeight,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.ptHeight)),
      slots: <PlateSlot>[
        ...plateRegister(
          alphabet: TimorLesteAlphabets.letters,
          count: prefix,
          left: left,
          top: _Layout.ptTop,
          width: _Layout.ptPitch,
          height: _Layout.ptSlot,
        ),
        ...plateRegister(
          alphabet: TimorLesteAlphabets.digits,
          count: 2,
          left: firstLeft,
          top: _Layout.ptTop,
          width: _Layout.ptPitch,
          height: _Layout.ptSlot,
        ),
        ...plateRegister(
          alphabet: TimorLesteAlphabets.digits,
          count: 2,
          left: secondLeft,
          top: _Layout.ptTop,
          width: _Layout.ptPitch,
          height: _Layout.ptSlot,
        ),
      ],
      labels: <PlateLabel>[
        _dash(dash1, _Layout.ptTop, _Layout.ptDash, _Layout.ptSlot),
        _dash(dash2, _Layout.ptTop, _Layout.ptDash, _Layout.ptSlot),
      ],
      textGroups: <PlateTextGroup>[
        PlateTextGroup(<int>[
          for (int i = 0; i < prefix; i++) i,
        ], key: 'prefix'),
        PlateTextGroup(<int>[prefix, prefix + 1], key: 'first'),
        PlateTextGroup(<int>[prefix + 2, prefix + 3], key: 'second'),
      ],
    );
  }

  static PlateSpec _stackedSpec() {
    final double content = 4 * _Layout.ptStackPitch + _Layout.ptStackDash;
    final double left = (_Layout.ptStackWidth - content) / 2;
    final double dash = left + 2 * _Layout.ptStackPitch;
    final double secondLeft = dash + _Layout.ptStackDash;
    return PlateSpec(
      id: 'tl.portuguese.stacked',
      country: TimorLesteCountry.timor_leste,
      canvasWidth: _Layout.ptStackWidth,
      canvasHeight: _Layout.ptStackHeight,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.ptStackHeight)),
      slots: <PlateSlot>[
        PlateSlot(
          alphabet: TimorLesteAlphabets.letters,
          box: PlateBox(
            (_Layout.ptStackWidth - _Layout.ptStackPitch) / 2,
            _Layout.ptStackTop,
            _Layout.ptStackPitch,
            _Layout.ptStackSlot,
          ),
        ),
        ...plateRegister(
          alphabet: TimorLesteAlphabets.digits,
          count: 2,
          left: left,
          top: _Layout.ptStackSecondTop,
          width: _Layout.ptStackPitch,
          height: _Layout.ptStackSlot,
        ),
        ...plateRegister(
          alphabet: TimorLesteAlphabets.digits,
          count: 2,
          left: secondLeft,
          top: _Layout.ptStackSecondTop,
          width: _Layout.ptStackPitch,
          height: _Layout.ptStackSlot,
        ),
      ],
      labels: <PlateLabel>[
        _dash(
          dash,
          _Layout.ptStackSecondTop,
          _Layout.ptStackDash,
          _Layout.ptStackSlot,
        ),
      ],
      textGroups: const <PlateTextGroup>[
        PlateTextGroup(<int>[0], key: 'prefix'),
        PlateTextGroup(<int>[1, 2], key: 'first'),
        PlateTextGroup(<int>[3, 4], key: 'second'),
      ],
    );
  }
}
