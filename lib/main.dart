import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/theme_provider.dart';

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
          // Theme cho light mode - chuyển đổi từ forui theme sang Material theme
          theme: lightTheme.toApproximateMaterialTheme(),
          // Theme cho dark mode - chuyển đổi từ forui theme sang Material theme
          darkTheme: darkTheme.toApproximateMaterialTheme(),
          // Xác định theme mode dựa trên brightness của theme hiện tại
          themeMode: theme.colors.brightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light,
          // Màn hình chính của ứng dụng
          home: Example(themeProvider: _themeProvider),
        );
      },
    );
  }
}

// Widget Example - màn hình ví dụ với nút chuyển đổi dark mode
class Example extends StatelessWidget {
  // ThemeProvider để quản lý và toggle dark mode
  final ThemeProvider themeProvider;
  const Example({super.key, required this.themeProvider});

  // Hàm build - xây dựng giao diện của màn hình
  @override
  Widget build(BuildContext context) => Center(
    // Sử dụng FScaffold để có background color tự động thay đổi theo theme
    child: FScaffold(
      child: Column(
        // Căn giữa theo trục chính
        mainAxisAlignment: MainAxisAlignment.center,
        // Căn giữa theo trục phụ
        crossAxisAlignment: CrossAxisAlignment.center,
        // Khoảng cách giữa các children
        spacing: 10,
        children: [
          // Nút để chuyển đổi giữa dark mode và light mode
          FButton(
            // Hàm xử lý khi nhấn nút - toggle dark mode
            onPress: () {
              themeProvider.toggleDarkMode();
            },
            // Icon hiển thị ở cuối nút (moon cho dark mode, sun cho light mode)
            suffix: Icon(themeProvider.isDarkMode ? FIcons.moon : FIcons.sun),
            // Text hiển thị trên nút
            child: Text(themeProvider.isDarkMode ? 'Dark Mode' : 'Light Mode'),
          ),
        ],
      ),
    ),
  );
}
