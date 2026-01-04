import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/auth/auth_provider.dart';
import 'package:network/core/theme/app_fonts.dart';

class UserAvatar extends StatelessWidget {
  final AuthProvider authProvider;
  final double size;
  final String? semanticsLabel;

  const UserAvatar({
    super.key,
    required this.authProvider,
    this.size = 40.0,
    this.semanticsLabel = 'User avatar',
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: authProvider,
      builder: (context, child) {
        final user = authProvider.user;

        return FAvatar(
          image: user?.image != null
              ? NetworkImage(user!.image!)
              : const AssetImage('assets/images/user.png'),
          size: size,
          semanticsLabel: semanticsLabel,
          fallback: Text(
            user?.initials ?? 'JD',
            style: AppFonts.bbhBartle(fontSize: size * 0.4),
          ),
        );
      },
    );
  }
}

