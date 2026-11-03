FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the resilient people of Timor-Leste to view examples:

https://platexample.ir/#/discover/timorleste:flutter

# timor_leste_plate

Timor-Leste's licence plates for plate_core: private and government plates with TLS, plus the historical Indonesian and Portuguese Timor plates; themes, alphabet, and more.

## Languages

| Language | Folder | Example |
| --- | --- | --- |
| Flutter / Dart | [`flutter/`](https://github.com/ArAd1Beyranvand/timor_leste_plate/tree/main/flutter) | [platexample](https://platexample.ir/#/discover/timorleste:flutter) |
| Kotlin | [`kotlin/`](https://github.com/ArAd1Beyranvand/timor_leste_plate/tree/main/kotlin) | [platexample](https://platexample.ir/#/discover/timorleste:kotlin) |
| Python | [`python/`](https://github.com/ArAd1Beyranvand/timor_leste_plate/tree/main/python) | [platexample](https://platexample.ir/#/discover/timorleste:python) |
| TypeScript | [`typescript/`](https://github.com/ArAd1Beyranvand/timor_leste_plate/tree/main/typescript) | [platexample](https://platexample.ir/#/discover/timorleste:typescript) |

## Quick start

### Install

```yaml
dependencies:
  plate_core: ^0.12.0
  timor_leste_plate: ^0.1.0
```

### Use

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

## Specs

Each spec is one plate layout.

- `TimorLestePlates.private`
- `TimorLestePlates.government`
- `TimorLestePlates.indonesian`
- `TimorLestePlates.portuguese`
- `TimorLestePlates.portugueseStacked`

## Themes

- `TimorLesteThemes.private`
- `TimorLesteThemes.government`
- `TimorLesteThemes.indonesian`
- `TimorLesteThemes.portuguese`

## Change it

`PlateCanvas` takes `spec:` (an entry of `TimorLestePlates`) and `theme:` (an entry of `TimorLesteThemes`). Set `validator:` to `TimorLesteValidator()` and `autoValidate: true` to show validation hints.

## Also included

- `TimorLesteCountry` — the country panel.
- `TimorLesteValidator` — the plate validator.

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

## License

See [LICENSE](https://github.com/ArAd1Beyranvand/timor_leste_plate/blob/main/LICENSE).
