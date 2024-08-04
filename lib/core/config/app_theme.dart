import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AppTheme {
  static Color seedColor = const Color.fromARGB(255, 84, 226, 66);

  static Color darkColor = const Color.fromARGB(255, 15, 15, 15);
  static Color lightColor = Colors.white;

  static ColorScheme colorScheme(bool isDarkMode) => ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        surface: isDarkMode ? darkColor : lightColor,
        onSurface: isDarkMode ? lightColor : darkColor,
        dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
      );

  static ThemeData theme(bool isDarkMode) {
    final scheme = colorScheme(isDarkMode);
    return ThemeData(
      colorScheme: scheme,
      fontFamily: "GeneralSans",
      visualDensity: VisualDensity.compact,
      splashFactory: kIsWeb ? NoSplash.splashFactory : InkSparkle.splashFactory,
      textTheme: const TextTheme(
        bodySmall: TextStyle(fontSize: 9),
        bodyMedium: TextStyle(fontSize: 12),
        bodyLarge: TextStyle(fontSize: 14),
        displayLarge: TextStyle(
          fontSize: 28,
          fontFamily: 'Satoshi',
        ),
        displayMedium: TextStyle(
          fontSize: 32,
          fontFamily: 'Satoshi',
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontFamily: 'Satoshi',
        ),
        headlineSmall: TextStyle(
          fontSize: 16,
          fontFamily: 'Satoshi',
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontFamily: 'Satoshi',
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontFamily: 'Satoshi',
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          fontFamily: 'Satoshi',
        ),
        titleMedium: TextStyle(
          fontSize: 22,
          fontFamily: 'Satoshi',
        ),
        titleLarge: TextStyle(
          fontSize: 26,
          fontFamily: 'Satoshi',
        ),
        labelSmall: TextStyle(fontSize: 9),
        labelMedium: TextStyle(fontSize: 12),
        labelLarge: TextStyle(fontSize: 14),
      ).apply(),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        fillColor: scheme.onSurface.withOpacity(0.025),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
        hintStyle: const TextStyle(fontSize: 14),
        errorStyle: const TextStyle(fontSize: 12),
        labelStyle: const TextStyle(fontSize: 14),
        counterStyle: const TextStyle(fontSize: 14),
        prefixStyle: const TextStyle(fontSize: 14),
        suffixStyle: const TextStyle(fontSize: 14),
        helperStyle: const TextStyle(fontSize: 14),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      ),
      iconTheme: const IconThemeData().copyWith(size: 16, color: scheme.onSurface),
    );
  }
}
