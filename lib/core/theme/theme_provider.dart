import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  // Key cho theme
  static const _themeKey = 'theme';
  // Tạo biến để lưu trữ theme đang chọn
  bool _isDarkMode = false;

  // Getter để lấy giá trị của biến _isDarkMode
  bool get isDarkMode => _isDarkMode;

  // Getter để lấy theme đang chọn
  FThemeData get currentTheme {
    return _isDarkMode ? FThemes.blue.dark : FThemes.blue.light;
  }

  // Constructor
  ThemeProvider() {
    _loadPreferences();
  }

  // Hàm để load preferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  // Hàm để toggle dark mode
  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }
}
