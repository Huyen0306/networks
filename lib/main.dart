import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/theme_provider.dart';

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
        final lightTheme = FThemes.blue.light;
        final darkTheme = FThemes.blue.dark;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          supportedLocales: FLocalizations.supportedLocales,
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates,
          ],
          builder: (_, child) => FTheme(data: theme, child: child!),
          theme: lightTheme.toApproximateMaterialTheme(),
          darkTheme: darkTheme.toApproximateMaterialTheme(),
          themeMode: theme.colors.brightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light,
          home: Example(themeProvider: _themeProvider),
        );
      },
    );
  }
}

class Example extends StatelessWidget {
  final ThemeProvider themeProvider;
  const Example({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) => Center(
    child: FScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          FButton(
            onPress: () {
              themeProvider.toggleDarkMode();
            },
            suffix: Icon(themeProvider.isDarkMode ? FIcons.moon : FIcons.sun),
            child: Text(themeProvider.isDarkMode ? 'Dark Mode' : 'Light Mode'),
          ),
        ],
      ),
    ),
  );
}
