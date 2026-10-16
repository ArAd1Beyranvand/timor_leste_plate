import 'package:plate_core/plate_core.dart';

/// A current plate: five digits as `NN·NNN`, and on a government plate the
/// letter `G`. No ranges are published, so none are checked. Reports, never
/// bars.
class TimorLesteValidator extends GatedPlateValidator {
  const TimorLesteValidator();

  @override
  String get gateGroup => 'second';

  static const String reasonDigits = 'The number is five digits, NN·NNN.';
  static const String reasonSuffix = 'A government plate ends in G.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!isDigitsOfLength(entry.group('first'), 2) ||
        !isDigitsOfLength(entry.group('second'), 3)) {
      return const PlateValidation.invalid(reasonDigits);
    }
    final String suffix = entry.group('suffix');
    if (suffix.isNotEmpty && suffix != 'G') {
      return const PlateValidation.invalid(reasonSuffix);
    }
    return const PlateValidation.valid();
  }
}

/// An expiry `MMYY` (month 01-12), the code `DF`, 1-4 digits and up to two
/// letters. The expiry's year is not range-checked.
class TimorLesteIndonesianValidator extends GatedPlateValidator {
  const TimorLesteIndonesianValidator();

  @override
  String get gateGroup => 'number';

  static const String reasonExpiry = 'The expiry is a month 01–12 and a year.';
  static const String reasonRegion = 'East Timor plates carry the code DF.';
  static const String reasonNumber = 'The number is 1 to 4 digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String expiry = entry.group('expiry');
    final int month =
        int.tryParse(expiry.length == 4 ? expiry.substring(0, 2) : '') ?? 0;
    if (!isDigitsOfLength(expiry, 4) || month < 1 || month > 12) {
      return const PlateValidation.invalid(reasonExpiry);
    }
    if (entry.group('prefix') != 'DF') {
      return const PlateValidation.invalid(reasonRegion);
    }
    final String number = entry.group('number');
    if (number.isEmpty || number.length > 4 || !isDigits(number)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}

/// The prefix `T` or `TP` and `NN-NN`.
class TimorLestePortugueseValidator extends GatedPlateValidator {
  const TimorLestePortugueseValidator();

  @override
  String get gateGroup => 'second';

  static const String reasonPrefix = 'The prefix is T or TP.';
  static const String reasonDigits = 'The number is four digits, NN-NN.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final String prefix = entry.group('prefix');
    if (prefix != 'T' && prefix != 'TP') {
      return const PlateValidation.invalid(reasonPrefix);
    }
    if (!isDigitsOfLength(entry.group('first'), 2) ||
        !isDigitsOfLength(entry.group('second'), 2)) {
      return const PlateValidation.invalid(reasonDigits);
    }
    return const PlateValidation.valid();
  }
}
