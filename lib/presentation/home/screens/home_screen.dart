import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/auth/auth_provider.dart';
import 'package:network/core/models/post_model.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/home/screens/post_detail_screen.dart';
import 'package:network/presentation/home/services/home_service.dart';
import 'package:network/presentation/home/widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  final AuthProvider authProvider;

  const HomeScreen({super.key, required this.authProvider});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeService = HomeService();
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

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
        title: Text(
          'Home',
          style: AppFonts.bbhBartle(
            fontSize: 40,
            color: context.theme.colors.primary,
          ),
        ),
        suffixes: [
          SizedBox(
            width: 220,
            child: FTextFormField(
              controller: _searchController,
              hint: 'Tìm bài viết...',
              clearable: (value) => value.text.isNotEmpty,
              style: (style) => style.copyWith(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: FutureBuilder(
            future: _searchQuery.isEmpty
                ? _homeService.getPosts()
                : _homeService.searchPosts(_searchQuery),
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

              if (posts.isEmpty) {
                return Center(
                  child: Text(
                    'Không tìm thấy bài viết nào',
                    style: AppFonts.inter(
                      color: context.theme.colors.mutedForeground,
                    ),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                itemCount: posts.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final postData = posts[index];
                  final post = PostModel.fromJson(postData);
                  return PostCard(
                    id: post.id,
                    title: post.title,
                    body: post.body,
                    tags: post.tags,
                    likes: post.likes,
                    dislikes: post.dislikes,
                    views: post.views,
                    userId: post.userId,
                    onViewDetail: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PostDetailScreen(post: post),
                        ),
                      );
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
