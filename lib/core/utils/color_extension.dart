import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension ColorExtension on Color {
  HSLColor get toHSLColor => HSLColor.fromColor(this);
  HSVColor get toHSVColor => HSVColor.fromColor(this);
}

extension ColorExtensionHSL on HSLColor {
  HSLColor withRelativeLightness(double value) {
    return withLightness(clampDouble(lightness + value, 0.0, 1.0));
  }

  HSLColor withRelativeSaturation(double value) {
    return withSaturation(clampDouble(saturation + value, 0.0, 1.0));
  }
}
