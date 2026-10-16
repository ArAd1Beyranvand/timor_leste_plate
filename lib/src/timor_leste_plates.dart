import 'dart:math';

import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'timor_leste_colors.dart';
import 'timor_leste_country.dart';

/// Ink positions in plate coordinates: reference plates flattened to the
/// article's 372x134 mm, ink projected onto each axis.
///
/// The current plate's ink is left of centre because the right 90 mm is the
/// room a government `G` takes; its screw dots are not drawn. The Indonesian
/// plate is laid on 372x134 with an expiry box under which the main row sits.
/// The Portuguese Timor plates have no published size, so their canvases are
/// the artwork's proportions scaled by 0.92.
///
/// Ink is deliberately under reference height: the reference digits are a
/// condensed face, a slot as tall as the plate allows prints ~55% of its
/// height as ink, and the engine shrinks a glyph wider than its slot, so ink
/// is ~65-85% of reference.
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

/// * [private] `NN·NNN` and [government] `NN·NNNG`, with `TLS` beneath; the
///   article's "four digits and G" contradicts its own example `05-204G`, so
///   the example is followed.
/// * [indonesian]: `04·85` expiry above `DF 1202 AA` (1976-1999), history.
/// * [portuguese] `T-12-34` / `TP-12-34`, and [portugueseStacked] with the
///   `T` above `12-34`. History.
///
/// Text groups, one slot each: [private]/[government] `first` (2), `second`
/// (3) and, on [government], `suffix`; [indonesian] `expiry`, `prefix`,
/// `number` (1-4 digits) and `suffix` (1-2 letters); the Portuguese plates
/// `prefix`, `first`, `second`.
abstract final class TimorLestePlates {
  /// `spacing` brings the font's advance up to the pitch; a variable field
  /// ([minLength]) has none.
  static PlateSlot _run(
    PlateAlphabet alphabet,
    int count,
    double left,
    double top,
    double pitch,
    double height, {
    int? minLength,
  }) => PlateSlot(
    alphabet: alphabet,
    box: PlateBox(left, top, count * pitch, height),
    length: count,
    minLength: minLength,
    spacing: minLength == null ? max(0, pitch - 0.6 * 0.72 * height) : 0,
  );

  static final PlateSpec private = _current(government: false);
  static final PlateSpec government = _current(government: true);

  static final PlateSpec indonesian = _indonesianSpec();
  static final PlateSpec portuguese = _portugueseSpec();

  static final PlateSpec portugueseStacked = _stackedSpec();

  static PlateSpec _current({required bool government}) {
    return PlateSpec(
      id: government ? 'tl.government' : 'tl.private',
      country: TimorLesteCountry.timor_leste,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
      slots: <PlateSlot>[
        _run(
          TimorLesteAlphabets.digits,
          2,
          _Layout.firstLeft,
          _Layout.digitTop,
          _Layout.digitPitch,
          _Layout.digitHeight,
        ),
        _run(
          TimorLesteAlphabets.digits,
          3,
          _Layout.secondLeft,
          _Layout.digitTop,
          _Layout.digitPitch,
          _Layout.digitHeight,
        ),
        if (government)
          PlateSlot(
            alphabet: TimorLesteAlphabets.letters,
            box: PlateBox(
              _Layout.suffixLeft,
              _Layout.digitTop,
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
        const PlateTextGroup(<int>[0], key: 'first'),
        const PlateTextGroup(<int>[1], key: 'second'),
        if (government) const PlateTextGroup(<int>[2], key: 'suffix'),
      ],
    );
  }

  static PlateSpec _indonesianSpec() {
    // The number and the suffix are variable fields, boxed for their longest
    // run: up to four digits and two letters.
    const int digits = 4, suffix = 2;
    const int cells = 2 + digits + suffix;
    const int gaps = 2;
    final double content = cells * _Layout.idPitch + gaps * _Layout.idGap;
    final double left = (_Layout.width - content) / 2;
    final double numberLeft = left + 2 * _Layout.idPitch + _Layout.idGap;
    final double suffixLeft =
        numberLeft + digits * _Layout.idPitch + _Layout.idGap;
    final double dotLeft = _Layout.idExpiryLeft + 2 * _Layout.idExpiryPitch;
    const double box = _Layout.idBoxLine;
    return PlateSpec(
      id: 'tl.indonesian',
      country: TimorLesteCountry.timor_leste,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.height)),
      bands: <PlateBand>[
        // A white pill with the field laid back inside it, clear of the edge.
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
        _run(
          TimorLesteAlphabets.digits,
          4,
          _Layout.idExpiryLeft,
          _Layout.idExpiryTop,
          _Layout.idExpiryPitch,
          _Layout.idExpiryHeight,
        ),
        _run(
          TimorLesteAlphabets.letters,
          2,
          left,
          _Layout.idTop,
          _Layout.idPitch,
          _Layout.idHeight,
        ),
        _run(
          TimorLesteAlphabets.digits,
          digits,
          numberLeft,
          _Layout.idTop,
          _Layout.idPitch,
          _Layout.idHeight,
          minLength: 1,
        ),
        _run(
          TimorLesteAlphabets.letters,
          suffix,
          suffixLeft,
          _Layout.idTop,
          _Layout.idPitch,
          _Layout.idHeight,
          minLength: 1,
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
      textGroups: const <PlateTextGroup>[
        PlateTextGroup(<int>[0], key: 'expiry'),
        PlateTextGroup(<int>[1], key: 'prefix'),
        PlateTextGroup(<int>[2], key: 'number'),
        PlateTextGroup(<int>[3], key: 'suffix'),
      ],
    );
  }

  static PlateLabel _dash(double left, double top, double width, double slot) =>
      PlateLabel(
        text: '-',
        box: PlateBox(left, top, width, slot),
        glyphHeight: slot,
      );

  static PlateSpec _portugueseSpec() {
    // `T` or `TP`: one variable field boxed for two letters.
    const int prefix = 2;
    final double content =
        prefix * _Layout.ptPitch + 4 * _Layout.ptPitch + 2 * _Layout.ptDash;
    final double left = (_Layout.ptWidth - content) / 2;
    final double dash1 = left + prefix * _Layout.ptPitch;
    final double firstLeft = dash1 + _Layout.ptDash;
    final double dash2 = firstLeft + 2 * _Layout.ptPitch;
    final double secondLeft = dash2 + _Layout.ptDash;
    return PlateSpec(
      id: 'tl.portuguese',
      country: TimorLesteCountry.timor_leste,
      canvasWidth: _Layout.ptWidth,
      canvasHeight: _Layout.ptHeight,
      noPanel: true,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, _Layout.ptHeight)),
      slots: <PlateSlot>[
        _run(
          TimorLesteAlphabets.letters,
          prefix,
          left,
          _Layout.ptTop,
          _Layout.ptPitch,
          _Layout.ptSlot,
          minLength: 1,
        ),
        _run(
          TimorLesteAlphabets.digits,
          2,
          firstLeft,
          _Layout.ptTop,
          _Layout.ptPitch,
          _Layout.ptSlot,
        ),
        _run(
          TimorLesteAlphabets.digits,
          2,
          secondLeft,
          _Layout.ptTop,
          _Layout.ptPitch,
          _Layout.ptSlot,
        ),
      ],
      labels: <PlateLabel>[
        _dash(dash1, _Layout.ptTop, _Layout.ptDash, _Layout.ptSlot),
        _dash(dash2, _Layout.ptTop, _Layout.ptDash, _Layout.ptSlot),
      ],
      textGroups: const <PlateTextGroup>[
        PlateTextGroup(<int>[0], key: 'prefix'),
        PlateTextGroup(<int>[1], key: 'first'),
        PlateTextGroup(<int>[2], key: 'second'),
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
        _run(
          TimorLesteAlphabets.digits,
          2,
          left,
          _Layout.ptStackSecondTop,
          _Layout.ptStackPitch,
          _Layout.ptStackSlot,
        ),
        _run(
          TimorLesteAlphabets.digits,
          2,
          secondLeft,
          _Layout.ptStackSecondTop,
          _Layout.ptStackPitch,
          _Layout.ptStackSlot,
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
        PlateTextGroup(<int>[1], key: 'first'),
        PlateTextGroup(<int>[2], key: 'second'),
      ],
    );
  }
}
