FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the resilient people of Timor-Leste to view examples:

https://platexample.ir/#/discover/timorleste:python

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

### Install (Python)

Copy `python/plates/countries/timor_leste/` into `plate_core/python/plates/countries/`.

Then run the tests from `plate_core/python/`: `pytest`.

### Use

```python
from plates.countries.timor_leste.data import SPECS, THEMES

spec = SPECS["tl.private"]
theme = THEMES["TimorLesteThemes.private"]
print(spec.id)
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

- Pick a spec: use another key of `SPECS`.
- Pick a theme: use another key of `THEMES`.
- Validators: `VALIDATORS` maps the names `TimorLesteValidator`, `TimorLesteIndonesianValidator`, `TimorLestePortugueseValidator` to classes.

## License

See [LICENSE](https://github.com/ArAd1Beyranvand/timor_leste_plate/blob/main/LICENSE).
