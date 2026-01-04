import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/app_fonts.dart';

class FriendCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String? imageUrl;
  final VoidCallback? onViewDetail;

  const FriendCard({
    super.key,
    required this.firstName,
    required this.lastName,
    this.imageUrl,
    this.onViewDetail,
  });

  String get fullName => '$firstName $lastName';

  @override
  Widget build(BuildContext context) {
    return FCard(
      style: (style) => style.copyWith(
        decoration: BoxDecoration(
          border: Border.all(color: context.theme.colors.border, width: 0.5),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Row(
        children: [
          FAvatar(
            image: imageUrl != null
                ? NetworkImage(imageUrl!)
                : const AssetImage('assets/images/user.png'),
            size: 80,
            semanticsLabel: 'Friend avatar',
            fallback: Text(
              '${firstName[0]}${lastName[0]}',
              style: AppFonts.bbhBartle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: AppFonts.bbhBartle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                FButton(
                  onPress: onViewDetail ?? () {},
                  style: FButtonStyle.secondary(),
                  child: Text(
                    'Xem chi tiết',
                    style: AppFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
