import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/auth/auth_provider.dart';
import 'package:network/core/theme/theme_provider.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/profile/widgets/auto_dark_mode_card.dart';
import 'package:network/presentation/profile/widgets/profile_info_card.dart';
import 'package:network/presentation/shared/widgets/user_avatar.dart';

class ProfileScreen extends StatefulWidget {
  final ThemeProvider themeProvider;
  final AuthProvider authProvider;

  const ProfileScreen({
    super.key,
    required this.themeProvider,
    required this.authProvider,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        suffixes: [UserAvatar(authProvider: widget.authProvider, size: 40.0)],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          spacing: 16,
          children: [
            ProfileInfoCard(user: widget.authProvider.user),
            AutoDarkModeCard(themeProvider: widget.themeProvider),
            FButton(
              onPress: () async {
                await widget.authProvider.logout();
              },
              style: FButtonStyle.primary(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  spacing: 6,
                  children: [
                    Text(
                      'Đăng xuất',
                      style: AppFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(FIcons.logOut, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
