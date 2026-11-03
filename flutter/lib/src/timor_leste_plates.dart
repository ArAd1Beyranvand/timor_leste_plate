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
  static const double width = 372, height = 134, digitTop = 8;
  static const double digitHeight = 100, digitPitch = 49.5, firstLeft = 3.5;
  static const double secondLeft = 146.5, suffixLeft = 297;
  static const double diamondCentreX = 127.6, diamondCentreY = 57;
  static const double diamondGlyph = 26, tlsCentreX = 188.8, tlsCentreY = 114;
  static const double tlsGlyph = 32;

  // Indonesian plate.
  static const double idPitch = 35.5, idGap = 28, idTop = 31.5, idHeight = 100;
  static const double idExpiryLeft = 137, idExpiryPitch = 21, idExpiryDot = 14;
  static const double idExpiryTop = 0.9, idExpiryHeight = 37, idBoxLeft = 14.8;
  static const double idBoxRight = 357, idBoxTop = 3, idBoxBottom = 36.5;
  static const double idBoxLine = 3.3;

  // Portuguese Timor.
  static const double ptWidth = 500, ptHeight = 111, ptTop = 3, ptSlot = 105;
  static const double ptPitch = 54, ptDash = 34, ptStackWidth = 300;
  static const double ptStackHeight = 212, ptStackTop = 7;
  static const double ptStackSecondTop = 112, ptStackSlot = 94;
  static const double ptStackPitch = 52, ptStackDash = 38;
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
  static const PlateAlphabet _digits = TimorLesteAlphabets.digits;
  static const PlateAlphabet _letters = TimorLesteAlphabets.letters;

  static final PlateSpec private = _current(government: false);
  static final PlateSpec government = _current(government: true);

  static final PlateSpec indonesian = _indonesianSpec();
  static final PlateSpec portuguese = _portugueseSpec();

  static final PlateSpec portugueseStacked = _stackedSpec();

  static PlateSpec _spec(
    String id,
    double width,
    double height, {
    required List<PlateSlot> slots,
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateBand> bands = const <PlateBand>[],
  }) => PlateSpec(
    id: id,
    country: TimorLesteCountry.timor_leste,
    canvasWidth: width,
    canvasHeight: height,
    noPanel: true,
    panel: PlatePanel(box: PlateBox(0, 0, 0, height)),
    bands: bands,
    slots: slots,
    labels: labels,
  );

  static PlateSpec _current({required bool government}) {
    PlateSlot digits(int n, double left, String group) => plateRun(
      _digits,
      n,
      left: left,
      top: _Layout.digitTop,
      pitch: _Layout.digitPitch,
      height: _Layout.digitHeight,
      group: group,
    );
    return _spec(
      government ? 'tl.government' : 'tl.private',
      _Layout.width,
      _Layout.height,
      slots: <PlateSlot>[
        digits(2, _Layout.firstLeft, 'first'),
        digits(3, _Layout.secondLeft, 'second'),
        if (government)
          const PlateSlot(
            alphabet: _letters,
            box: PlateBox(
              _Layout.suffixLeft,
              _Layout.digitTop,
              _Layout.digitPitch,
              _Layout.digitHeight,
            ),
            group: 'suffix',
          ),
      ],
      labels: const <PlateLabel>[
        PlateLabel(
          text: '◆',
          box: PlateBox.centered(
            _Layout.diamondCentreX,
            _Layout.diamondCentreY,
            40,
            _Layout.diamondGlyph,
          ),
          glyphHeight: _Layout.diamondGlyph,
        ),
        PlateLabel(
          text: 'T L S',
          box: PlateBox.centered(
            _Layout.tlsCentreX,
            _Layout.tlsCentreY,
            70,
            _Layout.tlsGlyph,
          ),
          glyphHeight: _Layout.tlsGlyph,
        ),
      ],
    );
  }

  static PlateSpec _indonesianSpec() {
    // The number and the suffix are variable fields, boxed for their longest
    // run: up to four digits and two letters.
    const double box = _Layout.idBoxLine;
    return _spec(
      'tl.indonesian',
      _Layout.width,
      _Layout.height,
      bands: const <PlateBand>[
        // A white pill with the field laid back inside it, clear of the edge.
        PlateBand(
          box: PlateBox.fromLTRB(
            _Layout.idBoxLeft,
            _Layout.idBoxTop,
            _Layout.idBoxRight,
            _Layout.idBoxBottom,
          ),
          color: TimorLesteColors.white,
          topCornerRadius: 8,
          bottomCornerRadius: 8,
        ),
        PlateBand(
          box: PlateBox.fromLTRB(
            _Layout.idBoxLeft + box,
            _Layout.idBoxTop + box,
            _Layout.idBoxRight - box,
            _Layout.idBoxBottom - box,
          ),
          color: TimorLesteColors.black,
          topCornerRadius: 5,
          bottomCornerRadius: 5,
        ),
      ],
      slots: <PlateSlot>[
        plateRun(
          _digits,
          4,
          left: _Layout.idExpiryLeft,
          top: _Layout.idExpiryTop,
          pitch: _Layout.idExpiryPitch,
          height: _Layout.idExpiryHeight,
          group: 'expiry',
        ),
        ...plateRow(
          const <PlateRowItem>[
            PlateRowRun(_letters, 2, group: 'prefix'),
            PlateRowRun(_digits, 4, minLength: 1, spacing: 0, group: 'number'),
            PlateRowRun(_letters, 2, minLength: 1, spacing: 0, group: 'suffix'),
          ],
          centre: _Layout.width / 2,
          top: _Layout.idTop,
          height: _Layout.idHeight,
          pitch: _Layout.idPitch,
          gap: _Layout.idGap,
        ).slots,
      ],
      labels: const <PlateLabel>[
        PlateLabel(
          text: '·',
          box: PlateBox(
            _Layout.idExpiryLeft + 2 * _Layout.idExpiryPitch,
            _Layout.idExpiryTop,
            _Layout.idExpiryDot,
            _Layout.idExpiryHeight,
          ),
          glyphHeight: _Layout.idExpiryHeight,
        ),
      ],
    );
  }

  /// `T` or `TP` (one variable field boxed for two letters), then two pairs
  /// of digits, dash-separated.
  static PlateSpec _portugueseSpec() {
    final PlateRowLayout row = plateRow(
      const <PlateRowItem>[
        PlateRowRun(_letters, 2, minLength: 1, spacing: 0, group: 'prefix'),
        PlateRowText('-', _Layout.ptDash),
        PlateRowRun(_digits, 2, group: 'first'),
        PlateRowText('-', _Layout.ptDash),
        PlateRowRun(_digits, 2, group: 'second'),
      ],
      centre: _Layout.ptWidth / 2,
      top: _Layout.ptTop,
      height: _Layout.ptSlot,
      pitch: _Layout.ptPitch,
    );
    return _spec(
      'tl.portuguese',
      _Layout.ptWidth,
      _Layout.ptHeight,
      slots: row.slots,
      labels: row.labels,
    );
  }

  static PlateSpec _stackedSpec() {
    PlateRowLayout row(List<PlateRowItem> items, double top) => plateRow(
      items,
      centre: _Layout.ptStackWidth / 2,
      top: top,
      height: _Layout.ptStackSlot,
      pitch: _Layout.ptStackPitch,
    );
    final PlateRowLayout digits = row(const <PlateRowItem>[
      PlateRowRun(_digits, 2, group: 'first'),
      PlateRowText('-', _Layout.ptStackDash),
      PlateRowRun(_digits, 2, group: 'second'),
    ], _Layout.ptStackSecondTop);
    return _spec(
      'tl.portuguese.stacked',
      _Layout.ptStackWidth,
      _Layout.ptStackHeight,
      slots: <PlateSlot>[
        ...row(const <PlateRowItem>[
          PlateRowRun(_letters, 1, spacing: 0, group: 'prefix'),
        ], _Layout.ptStackTop).slots,
        ...digits.slots,
      ],
      labels: digits.labels,
    );
  }
}
