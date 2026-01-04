# Hướng dẫn Implement Dark Mode với Forui

Tài liệu này hướng dẫn cách implement dark mode đơn giản với Forui trong dự án Flutter, chỉ cần một button để chuyển đổi giữa light mode và dark mode.

## Tổng quan

Dự án sử dụng:
- **Forui**: UI component library
- **ChangeNotifier**: Quản lý state của theme
- **SharedPreferences**: Lưu trữ preference của người dùng

## Các bước thực hiện

### Bước 1: Tạo ThemeProvider đơn giản

Tạo file `lib/core/theme_provider.dart` với logic đơn giản chỉ quản lý dark/light mode:

```dart
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _keyDarkMode = 'dark_mode';
  
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  FThemeData get currentTheme {
    return _isDarkMode 
        ? FThemes.zinc.dark  // Dark theme
        : FThemes.zinc.light; // Light theme
  }

  ThemeProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_keyDarkMode) ?? false;
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, _isDarkMode);
    notifyListeners();
  }
}
```

**Giải thích:**
- `_isDarkMode`: Biến boolean lưu trạng thái dark mode
- `currentTheme`: Getter trả về theme tương ứng (dark hoặc light)
- `_loadPreferences()`: Load preference từ SharedPreferences khi khởi tạo
- `toggleDarkMode()`: Method để chuyển đổi giữa dark và light mode

### Bước 2: Setup ThemeProvider trong main.dart

Cập nhật `lib/main.dart` để sử dụng ThemeProvider:

```dart
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'core/theme_provider.dart';
import 'presentation/main_screen.dart';

void main() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _themeProvider = ThemeProvider();

  @override
  void dispose() {
    _themeProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeProvider,
      builder: (context, child) {
        final theme = _themeProvider.currentTheme;

        return MaterialApp(
          supportedLocales: FLocalizations.supportedLocales,
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates
          ],
          builder: (_, child) => FTheme(
            data: theme,
            child: child!,
          ),
          theme: theme.toApproximateMaterialTheme(),
          darkTheme: theme.toApproximateMaterialTheme(),
          themeMode: theme.colors.brightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light,
          home: MainScreen(themeProvider: _themeProvider),
        );
      },
    );
  }
}
```

**Giải thích:**
- `AnimatedBuilder`: Lắng nghe thay đổi từ ThemeProvider và rebuild UI
- `FTheme`: Wrap app với Forui theme
- `themeMode`: Xác định theme mode dựa trên brightness

### Bước 3: Tạo Button Toggle Dark Mode

Tạo một widget button đơn giản để chuyển đổi dark mode. Có thể đặt ở bất kỳ đâu trong app, ví dụ trong `HomePage`:

```dart
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import '../../core/theme_provider.dart';

class HomePage extends StatelessWidget {
  final ThemeProvider themeProvider;
  
  const HomePage({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          // Button toggle dark mode
          AnimatedBuilder(
            animation: themeProvider,
            builder: (context, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode 
                      ? FIcons.sun  // Icon mặt trời khi đang dark mode
                      : FIcons.moon, // Icon mặt trăng khi đang light mode
                ),
                onPressed: () {
                  themeProvider.toggleDarkMode();
                },
                tooltip: themeProvider.isDarkMode 
                    ? 'Chuyển sang Light Mode'
                    : 'Chuyển sang Dark Mode',
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Text(
              'Home',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),
            // Button toggle dark mode ở trong body
            FButton(
              onPress: () {
                themeProvider.toggleDarkMode();
              },
              child: AnimatedBuilder(
                animation: themeProvider,
                builder: (context, child) {
                  return Text(
                    themeProvider.isDarkMode 
                        ? 'Chuyển sang Light Mode'
                        : 'Chuyển sang Dark Mode',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Giải thích:**
- `AnimatedBuilder`: Lắng nghe thay đổi từ themeProvider để update icon/text
- `toggleDarkMode()`: Gọi method để chuyển đổi mode
- Icon thay đổi dựa trên trạng thái hiện tại

### Bước 4: Cập nhật MainScreen để truyền ThemeProvider

Cập nhật `lib/presentation/main_screen.dart` để truyền ThemeProvider xuống các page:

```dart
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import '../../core/theme_provider.dart';
import 'features/home/home_page.dart';
// ... import các page khác

class MainScreen extends StatefulWidget {
  final ThemeProvider themeProvider;

  const MainScreen({super.key, required this.themeProvider});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(themeProvider: widget.themeProvider),
      // ... các page khác
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: FBottomNavigationBar(
        // ... bottom nav config
      ),
    );
  }
}
```

## Tóm tắt các file cần chỉnh sửa

1. **`lib/core/theme_provider.dart`**: Đơn giản hóa, chỉ quản lý dark/light mode
2. **`lib/main.dart`**: Đã có sẵn, không cần thay đổi nhiều
3. **`lib/presentation/features/home/home_page.dart`**: Thêm button toggle
4. **`lib/presentation/main_screen.dart`**: Truyền ThemeProvider xuống các page

## Kiểm tra

Sau khi implement:

1. Chạy app: `flutter run`
2. Click button toggle dark mode
3. Kiểm tra app chuyển đổi giữa light và dark mode
4. Restart app để kiểm tra preference được lưu đúng

## Lưu ý

- Theme sẽ tự động áp dụng cho toàn bộ app thông qua `FTheme` wrapper
- SharedPreferences sẽ lưu preference, app sẽ nhớ lựa chọn của người dùng
- Có thể đặt button toggle ở bất kỳ đâu: AppBar, Drawer, hoặc trong body của page

## Mở rộng (Tùy chọn)

Nếu muốn thêm nhiều theme colors sau này, có thể mở rộng `ThemeProvider` với enum và switch case, nhưng theo yêu cầu hiện tại, chỉ cần dark/light mode là đủ.

