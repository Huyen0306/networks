import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // Getter để lấy Inter font (dùng cho text thông thường)
  TextStyle get interFont => GoogleFonts.inter();

  // Getter để lấy BBH Bartle font (dùng cho heading hoặc special text)
  // Note: BBH Bartle có thể là Bebas Neue hoặc font khác, điều chỉnh theo yêu cầu
  TextStyle get bbhBartleFont => GoogleFonts.bebasNeue();

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
