"""Port of timor_leste_plate/lib/src/timor_leste_validators.dart."""
from __future__ import annotations

from plates.core.validators.plate_validator import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits, is_digits_of_length)


class TimorLesteValidator(GatedPlateValidator):
    gate_group = 'second'

    REASON_DIGITS = 'The number is five digits, NN·NNN.'
    REASON_SUFFIX = 'A government plate ends in G.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not is_digits_of_length(entry.group('first'), 2) or not is_digits_of_length(entry.group('second'), 3):
            return PlateValidation.invalid(self.REASON_DIGITS)
        suffix = entry.group('suffix')
        if suffix and suffix != 'G':
            return PlateValidation.invalid(self.REASON_SUFFIX)
        return PlateValidation.valid()


class TimorLesteIndonesianValidator(GatedPlateValidator):
    gate_group = 'number'

    REASON_EXPIRY = 'The expiry is a month 01–12 and a year.'
    REASON_REGION = 'East Timor plates carry the code DF.'
    REASON_NUMBER = 'The number is 1 to 4 digits.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        expiry = entry.group('expiry')
        if not is_digits_of_length(expiry, 4) or not 1 <= int(expiry[:2]) <= 12:
            return PlateValidation.invalid(self.REASON_EXPIRY)
        if entry.group('prefix') != 'DF':
            return PlateValidation.invalid(self.REASON_REGION)
        number = entry.group('number')
        if not number or len(number) > 4 or not is_digits(number):
            return PlateValidation.invalid(self.REASON_NUMBER)
        return PlateValidation.valid()


class TimorLestePortugueseValidator(GatedPlateValidator):
    gate_group = 'second'

    REASON_PREFIX = 'The prefix is T or TP.'
    REASON_DIGITS = 'The number is four digits, NN-NN.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if entry.group('prefix') not in ('T', 'TP'):
            return PlateValidation.invalid(self.REASON_PREFIX)
        if not is_digits_of_length(entry.group('first'), 2) or not is_digits_of_length(entry.group('second'), 2):
            return PlateValidation.invalid(self.REASON_DIGITS)
        return PlateValidation.valid()
