import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/theme_provider.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/profile/widgets/theme_option.dart';

class AutoDarkModeCard extends StatelessWidget {
  // ... (các biến và constructor)
  final ThemeProvider themeProvider;

  const AutoDarkModeCard({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    // ... (build method)
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContent(context),
              FDivider(
                style: (style) => style.copyWith(
                  color: context.theme.colors.border,
                  width: 0.5,
                ),
              ),
              _buildThemePicker(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemePicker(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double spacing = 12.0;
        final double itemWidth = (constraints.maxWidth - (spacing * 4)) / 5;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: AppColorTheme.values.map((theme) {
            return SizedBox(
              width: itemWidth,
              child: ThemeOption(
                color: _getThemeColor(theme),
                isSelected: themeProvider.colorTheme == theme,
                onTap: () => themeProvider.setColorTheme(theme),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Color _getThemeColor(AppColorTheme theme) {
    switch (theme) {
      case AppColorTheme.zinc:
        return FThemes.zinc.light.colors.primary;
      case AppColorTheme.slate:
        return FThemes.slate.light.colors.primary;
      case AppColorTheme.red:
        return FThemes.red.light.colors.primary;
      case AppColorTheme.rose:
        return FThemes.rose.light.colors.primary;
      case AppColorTheme.orange:
        return FThemes.orange.light.colors.primary;
      case AppColorTheme.green:
        return FThemes.green.light.colors.primary;
      case AppColorTheme.blue:
        return FThemes.blue.light.colors.primary;
      case AppColorTheme.yellow:
        return FThemes.yellow.light.colors.primary;
      case AppColorTheme.violet:
        return FThemes.violet.light.colors.primary;
    }
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              Text(
                'CHUYỂN ĐỔI MÀU NỀN',
                style: AppFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Theo dõi màu nền của hệ thống',
                style: AppFonts.inter(
                  color: context.theme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        FSwitch(
          value: themeProvider.isDarkMode,
          onChange: (_) => themeProvider.toggleDarkMode(),
        ),
      ],
    );
  }
}
