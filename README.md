FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the resilient people of Timor-Leste to view examples:

https://platexample.ir/#/discover/timorleste

# timor_leste_plate

Timor-Leste's licence plates for the `plate_core` library. The current 372x134 mm plates, black on white (private `NN·NNN`, government `NN·NNNG`), plus the historical Indonesian `DF` plate and the Portuguese Timor `T`/`TP` plates, both white on black.

## Install

```yaml
dependencies:
  plate_core: ^0.12.0
  timor_leste_plate: ^0.1.0
```

## Use

```dart
import 'package:plate_core/plate_core.dart';
import 'package:timor_leste_plate/timor_leste_plate.dart';

PlateCanvas(
  spec: TimorLestePlates.private,
  theme: TimorLesteThemes.private,
  validator: const TimorLesteValidator(),
  autoValidate: true,
  onChooseCharacter: noCharacterChooser,
);
```

## Contains

- `TimorLesteCountry` — country panel: `timor_leste`.
- `TimorLestePlates` — 5 plate specs: `private`, `government`, `indonesian`, `portuguese`, `portugueseStacked`.
- `TimorLesteThemes` — 4 themes: `private`, `government`, `indonesian`, `portuguese`.
- `TimorLesteValidator` — advisory validator; flags the frame, never blocks a keystroke.
- `TimorLesteIndonesianValidator` — advisory validator; flags the frame, never blocks a keystroke.
- `TimorLestePortugueseValidator` — advisory validator; flags the frame, never blocks a keystroke.

## Plates

* `private` `NN·NNN` and `government` `NN·NNNG`, with `TLS` beneath; the
  article's "four digits and G" contradicts its own example `05-204G`, so
  the example is followed.
* `indonesian`: `04·85` expiry above `DF 1202 AA` (1976-1999), history.
* `portuguese` `T-12-34` / `TP-12-34`, and `portugueseStacked` with the
  `T` above `12-34`. History.

Text groups, one slot each: `private`/`government` `first` (2), `second`
(3) and, on `government`, `suffix`; `indonesian` `expiry`, `prefix`,
`number` (1-4 digits) and `suffix` (1-2 letters); the Portuguese plates
`prefix`, `first`, `second`.

## Part of plate

Painted by [`plate_core`](https://pub.dev/packages/plate_core); alphabets shared through [`plate_alphabet`](https://pub.dev/packages/plate_alphabet); optional character picker in [`plate_keypad`](https://pub.dev/packages/plate_keypad).

