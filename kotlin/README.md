FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the resilient people of Timor-Leste to view examples:

https://platexample.ir/#/discover/timorleste:kotlin

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

### Install (Kotlin)

Copy `kotlin/src/commonMain/kotlin/plates/countries/timor_leste/` into `plate_core/kotlin/src/commonMain/kotlin/plates/countries/`.

Then run the tests from `plate_core/kotlin/`: `./gradlew jvmTest`.

### Use

```kotlin
import plates.countries.timor_leste.country

val spec = country.specs["tl.private"]
println(country.pkg)
```

## Specs

The specs are the same in every language (they come from shared data).

- `tl.private`
- `tl.government`
- `tl.indonesian`
- `tl.portuguese`
- `tl.portuguese.stacked`

## Themes

- `TimorLesteThemes.private`
- `TimorLesteThemes.indonesian`
- `TimorLesteThemes.portuguese`

## Change it

- Specs: `country.specs`, by id.
- Themes: `country.themes`.
- Validators: `country.validators` (`TimorLesteValidator`, `TimorLesteIndonesianValidator`, `TimorLestePortugueseValidator`).

## License

See [LICENSE](https://github.com/ArAd1Beyranvand/timor_leste_plate/blob/main/LICENSE).
