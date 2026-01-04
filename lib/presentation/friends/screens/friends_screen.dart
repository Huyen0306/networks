import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/friends/services/friends_service.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final friendsService = FriendsService();

    return FScaffold(
      scaffoldStyle: (style) => style.copyWith(
        headerDecoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: context.theme.colors.border, width: 0.5),
          ),
        ),
      ),
      header: FHeader(
        title: Text('Friends', style: AppFonts.bbhBartle(fontSize: 40)),
        suffixes: [
          FAvatar(
            image: const AssetImage('assets/images/user.png'),
            size: 40.0,
            semanticsLabel: 'User avatar',
            fallback: Text('JD', style: AppFonts.bbhBartle(fontSize: 16)),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: FutureBuilder(
            future: friendsService.getUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                    width: 200,
                    child: FProgress(semanticsLabel: 'Loading friends'),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Lỗi: ${snapshot.error}',
                    style: AppFonts.inter(),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: Text('Không có dữ liệu'));
              }

              final response = snapshot.data!;
              final users = response.data['users'] as List;

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Text(
                    '${user['firstName']} ${user['lastName']}',
                    style: AppFonts.inter(fontSize: 16),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
