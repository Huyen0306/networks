import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/models/user_model.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/profile/widgets/profile_info_card.dart';

class FriendDetailScreen extends StatelessWidget {
  final UserModel user;

  const FriendDetailScreen({super.key, required this.user});

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
        title: Text(user.fullName, style: AppFonts.bbhBartle(fontSize: 40)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            ProfileInfoCard(user: user),
            const SizedBox(height: 12),
            FButton(
              onPress: () => Navigator.of(context).pop(),
              style: FButtonStyle.secondary(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 6,
                  children: [
                    const Icon(FIcons.chevronLeft, size: 16),
                    Text(
                      'Quay lại',
                      style: AppFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
