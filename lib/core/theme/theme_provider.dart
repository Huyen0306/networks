import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  // Key để lưu trạng thái dark mode trong SharedPreferences
  static const _themeKey = 'theme';
  // Biến để lưu trữ trạng thái dark mode (true = dark mode, false = light mode)
  bool _isDarkMode = false;

  // Getter để lấy trạng thái dark mode hiện tại
  bool get isDarkMode => _isDarkMode;

  // Getter để lấy theme đang được sử dụng (dark hoặc light)
  FThemeData get currentTheme {
    return isDarkMode ? FThemes.blue.dark : FThemes.blue.light;
  }

  // Constructor - khởi tạo và tải trạng thái dark mode từ SharedPreferences
  ThemeProvider() {
    _loadPreferences();
  }

  // Hàm để tải trạng thái dark mode từ SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  // Hàm để chuyển đổi giữa dark mode và light mode
  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }
}
