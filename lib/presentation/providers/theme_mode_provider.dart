import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider that Manages the current theme mode.
final themeModeProvider = ChangeNotifierProvider<ThemeModeNotifier>((ref) {
  return ThemeModeNotifier();
});

/// Manages the current theme mode.
class ThemeModeNotifier extends ChangeNotifier {
  /// Initializes the provider with the saved theme mode from shared preferences.
  ThemeModeNotifier() {
    SharedPreferences.getInstance().then((value) {
      themeMode = ThemeMode.values[value.getInt("themeMode") ?? 0];
      notifyListeners();
    });
  }

  /// Initializes the provider with a given theme mode.
  ThemeModeNotifier.define(ThemeMode newThemeMode) {
    themeMode = newThemeMode;
  }

  /// The current theme mode.
  ThemeMode themeMode = ThemeMode.system;

  /// Sets the theme mode.
  void setThemeMode(ThemeMode newThemeMode) {
    themeMode = newThemeMode;
    notifyListeners();
    _saveThemeMode();
  }

  /// Increments the theme mode by one.
  void nextThemeMode() {
    themeMode = ThemeMode.values[(themeMode.index + 1) % ThemeMode.values.length];
    notifyListeners();
    _saveThemeMode();
  }

  /// Reads the value from ThemeModeProvider to determinate the current brightness.
  bool get isDarkMode {
    final mode = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return themeMode == ThemeMode.system ? mode == Brightness.dark : themeMode == ThemeMode.dark;
  }

  /// Saves the theme mode in shared preferences.
  void _saveThemeMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("themeMode", themeMode.index);
  }
}
