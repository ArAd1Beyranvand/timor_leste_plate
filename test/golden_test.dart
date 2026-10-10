import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timor_leste_plate/timor_leste_plate.dart';
import 'package:plate_core/plate_core.dart';

/// One golden per category, drawn with real bold faces so the ink can be
/// measured against the references (`platekit golden-check`).
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  setUpAll(() async {
    final FontLoader loader = FontLoader('Roboto');
    for (final String path in const <String>[
      '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',
    ]) {
      final File face = File(path);
      if (!face.existsSync()) continue;
      loader.addFont(face.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  });

  /// category id -> (spec, theme, space-separated sample value)
  final Map<String, (PlateSpec, PlateTheme, String)> cases =
      <String, (PlateSpec, PlateTheme, String)>{
        'private': (
          TimorLestePlates.private,
          TimorLesteThemes.private,
          '1 4 8 7 5',
        ),
        'government': (
          TimorLestePlates.government,
          TimorLesteThemes.government,
          '0 5 2 0 4 G',
        ),
        'indonesian': (
          TimorLestePlates.indonesian(),
          TimorLesteThemes.indonesian,
          '0 4 8 5 D F 1 2 0 2 A A',
        ),
        'portuguese_t': (
          TimorLestePlates.portuguese(),
          TimorLesteThemes.portuguese,
          'T 1 2 3 4',
        ),
        'portuguese_tp': (
          TimorLestePlates.portuguese(prefix: 2),
          TimorLesteThemes.portuguese,
          'T P 1 2 3 4',
        ),
        'portuguese_stacked': (
          TimorLestePlates.portugueseStacked,
          TimorLesteThemes.portuguese,
          'T 1 2 3 4',
        ),
      };

  for (final MapEntry<String, (PlateSpec, PlateTheme, String)> c
      in cases.entries) {
    testWidgets(c.key, (tester) async {
      final (PlateSpec spec, PlateTheme theme, String values) = c.value;
      final PlateController controller = PlateController.fromValues(
        spec,
        values.split(' '),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 680,
                height: 300,
                child: PlateThemeScope(
                  theme: theme,
                  child: PlateView(
                    controller: controller,
                    theme: theme,
                    country: TimorLesteCountry.timor_leste,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PlateView),
        matchesGoldenFile('goldens/tl_${c.key}.png'),
      );
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
    });
  }
}
