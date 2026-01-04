import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network/core/theme/theme_provider.dart';
import 'package:network/presentation/main_screen.dart';

// Hàm main - điểm khởi đầu của ứng dụng
void main() {
  runApp(const Application());
}

// Widget Application - widget gốc của ứng dụng, quản lý theme và MaterialApp
class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

// State của Application - quản lý ThemeProvider và xây dựng MaterialApp
class _ApplicationState extends State<Application> {
  // Tạo instance của ThemeProvider để quản lý theme
  final _themeProvider = ThemeProvider();

  // Hàm dispose - giải phóng tài nguyên khi widget bị hủy
  @override
  void dispose() {
    _themeProvider.dispose();
    super.dispose();
  }

  // Hàm build - xây dựng giao diện của ứng dụng
  @override
  Widget build(BuildContext context) {
    // Sử dụng AnimatedBuilder để tự động rebuild khi theme thay đổi
    return AnimatedBuilder(
      animation: _themeProvider,
      builder: (context, child) {
        // Lấy theme hiện tại từ ThemeProvider
        final theme = _themeProvider.currentTheme;
        // Tạo light theme và dark theme riêng biệt cho MaterialApp
        final lightTheme = FThemes.blue.light;
        final darkTheme = FThemes.blue.dark;

        // Tạo Material theme với Inter font
        final lightMaterialTheme = lightTheme
            .toApproximateMaterialTheme()
            .copyWith(
              textTheme: GoogleFonts.interTextTheme(
                lightTheme.toApproximateMaterialTheme().textTheme,
              ),
            );
        final darkMaterialTheme = darkTheme
            .toApproximateMaterialTheme()
            .copyWith(
              textTheme: GoogleFonts.interTextTheme(
                darkTheme.toApproximateMaterialTheme().textTheme,
              ),
            );

        return MaterialApp(
          // Tắt banner debug ở góc trên bên phải
          debugShowCheckedModeBanner: false,
          // Các locale được hỗ trợ từ forui package
          supportedLocales: FLocalizations.supportedLocales,
          // Các localization delegates từ forui package
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates,
          ],
          // Builder để wrap toàn bộ app với FTheme để sử dụng forui theme
          builder: (_, child) => FTheme(data: theme, child: child!),
          // Theme cho light mode - chuyển đổi từ forui theme sang Material theme với Inter font
          theme: lightMaterialTheme,
          // Theme cho dark mode - chuyển đổi từ forui theme sang Material theme với Inter font
          darkTheme: darkMaterialTheme,
          // Xác định theme mode dựa trên brightness của theme hiện tại
          themeMode: theme.colors.brightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light,
          // Màn hình chính của ứng dụng
          home: MainScreen(themeProvider: _themeProvider),
        );
      },
    );
  }
}
