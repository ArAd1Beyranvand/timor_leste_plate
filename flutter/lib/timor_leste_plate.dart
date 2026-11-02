/// Timor-Leste's licence plates for the `plate_core` library.
///
/// The current 372x134 mm plates, black on white (private `NN·NNN`,
/// government `NN·NNNG`), plus the historical Indonesian `DF` plate and the
/// Portuguese Timor `T`/`TP` plates, both white on black.
library;

// TODO(py): [D5] one module `plates.countries.timor_leste`; assets via importlib.resources.
// TODO(ts): [D5] one subpath export `./countries/timor_leste`; tree-shakable.
// TODO(kt): [D5] package `countries.timor_leste` in the countries module.
export 'src/timor_leste_colors.dart';
export 'src/timor_leste_country.dart';
export 'src/timor_leste_plates.dart';
export 'src/timor_leste_themes.dart';
export 'src/timor_leste_validators.dart';
export 'package:plate_alphabet/plate_alphabet.dart' show TimorLesteAlphabets;
