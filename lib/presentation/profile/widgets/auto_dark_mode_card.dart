import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/theme_provider.dart';
import 'package:network/core/theme/app_fonts.dart';

class AutoDarkModeCard extends StatelessWidget {
  final ThemeProvider themeProvider;

  const AutoDarkModeCard({super.key, required this.themeProvider});

  static const double _spacingBetween = 16.0;
  static const double _verticalSpacing = 6.0;
  static const double _titleFontSize = 16.0;

  @override
  Widget build(BuildContext context) {
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
    return GridView.count(
      crossAxisCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1,
      children: AppColorTheme.values.map((theme) {
        return _ThemeOption(
          color: _getThemeColor(theme),
          isSelected: themeProvider.colorTheme == theme,
          onTap: () => themeProvider.setColorTheme(theme),
        );
      }).toList(),
    );
  }

  Color _getThemeColor(AppColorTheme theme) {
    // ... (giữ nguyên logic màu sắc)
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
            children: [
              Text(
                'CHUYỂN ĐỔI MÀU NỀN',
                style: AppFonts.inter(
                  fontSize: _titleFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: _verticalSpacing),
              Text(
                'Theo dõi màu nền của hệ thống',
                style: AppFonts.inter(
                  color: context.theme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: _spacingBetween),
        FSwitch(
          value: themeProvider.isDarkMode,
          onChange: (_) => themeProvider.toggleDarkMode(),
        ),
      ],
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: isSelected
              ? Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51), // ~0.2 opacity
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                          ),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}
