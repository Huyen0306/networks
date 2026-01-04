import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/app_fonts.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FCard(
      style: (style) => style.copyWith(
        decoration: BoxDecoration(
          border: Border.all(color: context.theme.colors.border, width: 0.5),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                FAvatar(
                  image: const AssetImage('assets/images/user.png'),
                  size: 80.0,
                  semanticsLabel: 'User avatar',
                  fallback: Text('JD', style: AppFonts.bbhBartle(fontSize: 32)),
                ),
                const SizedBox(height: 16),
                Text(
                  'Thông tin cá nhân',
                  style: AppFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Xem và chỉnh sửa thông tin cá nhân của bạn',
                  style: AppFonts.inter(
                    fontSize: 14,
                    color: context.theme.colors.mutedForeground,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
