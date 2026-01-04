import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/theme_provider.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/profile/widgets/auto_dark_mode_card.dart';
import 'package:network/presentation/profile/widgets/profile_info_card.dart';

class ProfileScreen extends StatelessWidget {
  final ThemeProvider themeProvider;

  const ProfileScreen({super.key, required this.themeProvider});

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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          spacing: 16,
          children: [
            const ProfileInfoCard(),
            AutoDarkModeCard(themeProvider: themeProvider),
          ],
        ),
      ),
    );
  }
}
