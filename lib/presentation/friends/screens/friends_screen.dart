import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/app_fonts.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        titleTextStyle: AppFonts.bbhBartle(
          fontSize: 24,
          color: context.theme.colors.foreground,
        ),
        backgroundColor: context.theme.colors.background,
        elevation: 0,
      ),
      body: FScaffold(
        child: Center(
          child: Text('Friends'),
        ),
      ),
    );
  }
}

