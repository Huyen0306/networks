import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/app_fonts.dart';

class ProfileInfoList extends StatelessWidget {
  const ProfileInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    return FTileGroup(
      divider: FItemDivider.full,
      style: (style) => style.copyWith(
        decoration: BoxDecoration(
          border: Border.all(color: context.theme.colors.border, width: 0.5),
          borderRadius: BorderRadius.circular(18),
        ),
        dividerWidth: 0.5,
      ),
      children: [
        FTile(
          title: Text('Họ và tên', style: AppFonts.inter()),
          subtitle: const Text('Vvvv'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () {
            // Handle edit name
          },
        ),
        FTile(
          title: const Text('Email'),
          subtitle: const Text('vvvvvvv25423@gmail.com'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () {
            // Handle edit email
          },
        ),
        FTile(
          title: const Text('Giới tính'),
          subtitle: const Text('Nữ'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () {
            // Handle edit gender
          },
        ),
        FTile(
          title: const Text('Tên đăng nhập'),
          subtitle: const Text('vvvvvvvvv578'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () {
            // Handle edit username
          },
        ),
        FTile(
          title: const Text('Mật khẩu'),
          subtitle: const Text('••••••••'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () {
            // Handle edit password
          },
        ),
      ],
    );
  }
}
