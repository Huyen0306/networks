import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  final ThemeProvider themeProvider;

  const ProfileScreen({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: Center(
        child: Text('Profile'),
      ),
    );
  }
}

