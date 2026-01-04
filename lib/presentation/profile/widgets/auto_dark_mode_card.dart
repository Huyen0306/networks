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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _ThemeOption(
          color: const Color(0xFF0084FF), // Màu xanh như trong ảnh
          isSelected: !themeProvider.isDarkMode,
          onTap: () {
            if (themeProvider.isDarkMode) {
              themeProvider.toggleDarkMode();
            }
          },
        ),
        const SizedBox(width: 12),
        _ThemeOption(
          color: Colors.black, // Màu đen như trong ảnh
          isSelected: themeProvider.isDarkMode,
          onTap: () {
            if (!themeProvider.isDarkMode) {
              themeProvider.toggleDarkMode();
            }
          },
        ),
      ],
    );
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
      child: Container(
        width: 64,
        height: 64,
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
    );
  }
}
