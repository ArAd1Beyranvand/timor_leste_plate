import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';
import 'package:timor_leste_plate/timor_leste_plate.dart';

void main() => runApp(
  PlateExampleApp(
    spec: TimorLestePlates.private,
    theme: TimorLesteThemes.private,
  ),
);
