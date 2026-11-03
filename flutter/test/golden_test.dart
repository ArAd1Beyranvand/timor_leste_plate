import 'package:flutter_test/flutter_test.dart';
import 'package:plate_core/plate_core.dart';
import 'package:plate_core/testing.dart';
import 'package:timor_leste_plate/timor_leste_plate.dart';

void main() {
  plateGoldens('tl', TimorLesteCountry.timor_leste, <String, PlateGoldenCase>{
    'private': (TimorLestePlates.private, TimorLesteThemes.private, '14 875'),
    'government': (
      TimorLestePlates.government,
      TimorLesteThemes.government,
      '05 204 G',
    ),
    'indonesian': (
      TimorLestePlates.indonesian,
      TimorLesteThemes.indonesian,
      '0485 DF 1202 AA',
    ),
    'portuguese_t': (
      TimorLestePlates.portuguese,
      TimorLesteThemes.portuguese,
      'T 12 34',
    ),
    'indonesian_short': (
      TimorLestePlates.indonesian,
      TimorLesteThemes.indonesian,
      '0485 DF 12 A',
    ),
    'portuguese_tp': (
      TimorLestePlates.portuguese,
      TimorLesteThemes.portuguese,
      'TP 12 34',
    ),
    'portuguese_stacked': (
      TimorLestePlates.portugueseStacked,
      TimorLesteThemes.portuguese,
      'T 12 34',
    ),
  });

  test('variable fields complete at their minimum', () {
    final PlateController c = PlateController.fromValues(
      TimorLestePlates.indonesian,
      ['0485', 'DF', '1', 'A'],
    );
    expect(c.isCompleted, isTrue);
    c.setAt(2, '');
    expect(c.isCompleted, isFalse);
    c.dispose();
    final PlateController t = PlateController.fromValues(
      TimorLestePlates.portuguese,
      ['T', '12', '34'],
    );
    expect(t.isCompleted, isTrue);
    t.dispose();
  });
}
