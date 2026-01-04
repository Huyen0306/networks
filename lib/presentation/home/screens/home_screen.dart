import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/auth/auth_provider.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/home/services/home_service.dart';
import 'package:network/presentation/home/widgets/post_card.dart';
import 'package:network/presentation/shared/widgets/user_avatar.dart';

class HomeScreen extends StatelessWidget {
  final AuthProvider authProvider;

  const HomeScreen({
    super.key,
    required this.authProvider,
  });

  @override
  Widget build(BuildContext context) {
    final homeService = HomeService();

    return FScaffold(
      scaffoldStyle: (style) => style.copyWith(
        headerDecoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: context.theme.colors.border, width: 0.5),
          ),
        ),
      ),
      header: FHeader(
        title: Text('Home', style: AppFonts.bbhBartle(fontSize: 40)),
        suffixes: [
          UserAvatar(
            authProvider: authProvider,
            size: 40.0,
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: FutureBuilder(
            future: homeService.getPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                    width: 200,
                    child: FProgress(semanticsLabel: 'Loading posts'),
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
              final posts = response.data['posts'] as List;

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                itemCount: posts.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostCard(
                    id: post['id'] ?? 0,
                    title: post['title'] ?? '',
                    body: post['body'] ?? '',
                    tags: (post['tags'] as List?)?.cast<String>() ?? [],
                    likes: post['reactions']?['likes'] ?? 0,
                    dislikes: post['reactions']?['dislikes'] ?? 0,
                    views: post['views'] ?? 0,
                    userId: post['userId'] ?? 0,
                    onViewDetail: () {
                      // Xử lý xem chi tiết
                    },
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
