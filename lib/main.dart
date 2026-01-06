import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network/core/auth/auth_provider.dart';
import 'package:network/core/posts/post_provider.dart';
import 'package:network/core/theme/theme_provider.dart';
import 'package:network/presentation/login/screens/login_screen.dart';
import 'package:network/presentation/main_screen.dart';

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
  final _authProvider = AuthProvider();
  final _postProvider = PostProvider();

  @override
  void dispose() {
    _themeProvider.dispose();
    _authProvider.dispose();
    _postProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder để tự động rebuild khi theme thay đổi
    return AnimatedBuilder(
      animation: Listenable.merge([
        _themeProvider,
        _authProvider,
        _postProvider,
      ]),
      builder: (context, child) {
        final theme = _themeProvider.currentTheme;
        final lightTheme = FThemes.blue.light;
        final darkTheme = FThemes.blue.dark;

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
          debugShowCheckedModeBanner: false,
          // Các locale được hỗ trợ từ forui package
          supportedLocales: FLocalizations.supportedLocales,
          // Các localization delegates từ forui package
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates,
          ],
          // Builder để wrap toàn bộ app với FTheme và FToaster để dùng toast
          builder: (_, child) => FTheme(
            data: theme,
            child: FToaster(
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                behavior: HitTestBehavior.opaque,
                child: child!,
              ),
            ),
          ),
          theme: lightMaterialTheme,
          darkTheme: darkMaterialTheme,
          // Xác định theme mode dựa trên brightness của theme hiện tại
          themeMode: theme.colors.brightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light,
          home: _authProvider.isLoggedIn
              ? MainScreen(
                  themeProvider: _themeProvider,
                  authProvider: _authProvider,
                  postProvider: _postProvider,
                )
              : LoginScreen(authProvider: _authProvider),
        );
      },
    );
  }
}
