import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/models/user_model.dart';

class ProfileInfoList extends StatelessWidget {
  final UserModel? user;

  const ProfileInfoList({
    super.key,
    required this.user,
  });

  String _getGenderText(String? gender) {
    if (gender == null || gender.isEmpty) return 'Chưa cập nhật';
    switch (gender.toLowerCase()) {
      case 'male':
      case 'nam':
        return 'Nam';
      case 'female':
      case 'nữ':
        return 'Nữ';
      default:
        return gender;
    }
  }

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
          title: const Text('Họ và tên'),
          subtitle: Text(user?.fullName ?? 'Chưa cập nhật'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () {
            // Handle edit name
          },
        ),
        FTile(
          title: const Text('Email'),
          subtitle: Text(user?.email ?? 'Chưa cập nhật'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () {
            // Handle edit email
          },
        ),
        FTile(
          title: const Text('Giới tính'),
          subtitle: Text(_getGenderText(user?.gender)),
          suffix: const Icon(FIcons.chevronRight),
          onPress: () {
            // Handle edit gender
          },
        ),
        FTile(
          title: const Text('Tên đăng nhập'),
          subtitle: Text(user?.username ?? 'Chưa cập nhật'),
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
