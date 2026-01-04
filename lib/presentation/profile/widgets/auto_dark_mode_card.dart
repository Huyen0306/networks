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
            children: [
              _buildContent(context),
              FDivider(
                style: (style) => style.copyWith(
                  color: context.theme.colors.border,
                  width: 0.5,
                ),
              ),
            ],
          ),
        );
      },
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
