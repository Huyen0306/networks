import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/theme_provider.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/profile/widgets/auto_dark_mode_card.dart';
import 'package:network/presentation/profile/widgets/profile_info_card.dart';

class ProfileScreen extends StatefulWidget {
  final ThemeProvider themeProvider;

  const ProfileScreen({super.key, required this.themeProvider});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedColorIndex = 0;

  final List<ColorOption> _colors = [
    ColorOption(color: Colors.blue, isPremium: false),
    ColorOption(color: Colors.black, isPremium: false),
    ColorOption(color: Colors.red, isPremium: false),
    ColorOption(color: Colors.amber, isPremium: true),
    ColorOption(color: Colors.pink, isPremium: true),
    ColorOption(color: Colors.teal, isPremium: true),
    ColorOption(color: Colors.purple, isPremium: true),
  ];

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      scaffoldStyle: (style) => style.copyWith(
        headerDecoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: context.theme.colors.border, width: 0.5),
          ),
        ),
      ),
      header: FHeader(
        title: Text('Profile', style: AppFonts.bbhBartle(fontSize: 40)),
        suffixes: [
          FAvatar(
            image: const AssetImage('assets/images/user.png'),
            size: 40.0,
            semanticsLabel: 'User avatar',
            fallback: Text('JD', style: AppFonts.bbhBartle(fontSize: 16)),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          spacing: 16,
          children: [
            const ProfileInfoCard(),
            AutoDarkModeCard(themeProvider: widget.themeProvider),
          ],
        ),
      ),
    );
  }
}

class ColorOption {
  final Color color;
  final bool isPremium;

  ColorOption({required this.color, required this.isPremium});
}
