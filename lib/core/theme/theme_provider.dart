import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppColorTheme {
  zinc,
  slate,
  red,
  rose,
  orange,
  green,
  blue,
  yellow,
  violet,
}

class ThemeProvider extends ChangeNotifier {
  static const _themeKey = 'theme';
  static const _colorThemeKey = 'color_theme';

  bool _isDarkMode = false;
  AppColorTheme _colorTheme = AppColorTheme.blue;

  bool get isDarkMode => _isDarkMode;
  AppColorTheme get colorTheme => _colorTheme;

  FThemeData get currentTheme {
    return _getThemeData(_colorTheme, _isDarkMode);
  }

  FThemeData _getThemeData(AppColorTheme theme, bool isDark) {
    switch (theme) {
      case AppColorTheme.zinc:
        return isDark ? FThemes.zinc.dark : FThemes.zinc.light;
      case AppColorTheme.slate:
        return isDark ? FThemes.slate.dark : FThemes.slate.light;
      case AppColorTheme.red:
        return isDark ? FThemes.red.dark : FThemes.red.light;
      case AppColorTheme.rose:
        return isDark ? FThemes.rose.dark : FThemes.rose.light;
      case AppColorTheme.orange:
        return isDark ? FThemes.orange.dark : FThemes.orange.light;
      case AppColorTheme.green:
        return isDark ? FThemes.green.dark : FThemes.green.light;
      case AppColorTheme.blue:
        return isDark ? FThemes.blue.dark : FThemes.blue.light;
      case AppColorTheme.yellow:
        return isDark ? FThemes.yellow.dark : FThemes.yellow.light;
      case AppColorTheme.violet:
        return isDark ? FThemes.violet.dark : FThemes.violet.light;
    }
  }

  TextStyle get interFont => GoogleFonts.inter();
  TextStyle get bbhBartleFont => GoogleFonts.bebasNeue();

  ThemeProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeKey) ?? false;
    final colorThemeIndex =
        prefs.getInt(_colorThemeKey) ?? AppColorTheme.blue.index;
    _colorTheme = AppColorTheme.values[colorThemeIndex];
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }

  Future<void> setColorTheme(AppColorTheme theme) async {
    _colorTheme = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorThemeKey, theme.index);
    notifyListeners();
  }
}
