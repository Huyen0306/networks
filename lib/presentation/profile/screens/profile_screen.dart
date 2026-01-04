import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/theme_provider.dart';
import 'package:network/core/theme/app_fonts.dart';

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
        child: Column(children: [_buildAutoDarkModeCard(context)]),
      ),
    );
  }

  Widget _buildAutoDarkModeCard(BuildContext context) {
    return AnimatedBuilder(
      animation: themeProvider,
      builder: (context, child) {
        return FCard(
          style: (style) => style.copyWith(
            decoration: BoxDecoration(
              border: Border.all(
                color: context.theme.colors.border,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CHUYỂN ĐỔI MÀU NỀN',
                        style: AppFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Theo dõi màu nền của hệ thống',
                        style: AppFonts.inter(
                          color: context.theme.colors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                FSwitch(
                  value: themeProvider.isDarkMode,
                  onChange: (value) {
                    themeProvider.toggleDarkMode();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
