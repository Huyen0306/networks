import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/theme_provider.dart';
import 'package:network/core/theme/app_fonts.dart';

class ProfileScreen extends StatelessWidget {
  final ThemeProvider themeProvider;

  const ProfileScreen({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        titleTextStyle: AppFonts.bbhBartle(
          fontSize: 24,
          color: context.theme.colors.foreground,
        ),
        backgroundColor: context.theme.colors.background,
        elevation: 0,
      ),
      body: FScaffold(child: Center(child: Text('Profile'))),
    );
  }
}
