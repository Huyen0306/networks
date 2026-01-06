import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/auth/auth_provider.dart';
import 'package:network/core/models/post_model.dart';
import 'package:network/core/posts/post_provider.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/home/screens/post_detail_screen.dart';
import 'package:network/presentation/home/services/home_service.dart';
import 'package:network/presentation/home/widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  final AuthProvider authProvider;
  final PostProvider postProvider;

  const HomeScreen({
    super.key,
    required this.authProvider,
    required this.postProvider,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeService = HomeService();
  final _searchController = TextEditingController();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  String _searchQuery = '';
  bool _isCreatingPost = false;
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  Future<void> _handleCreatePost() async {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      return;
    }

    setState(() => _isCreatingPost = true);

    try {
      // Gọi API để tạo post (dù không lưu thực sự)
      await _homeService.createPost(
        title: title,
        body: body,
        userId: widget.authProvider.user?.id ?? 1,
      );

      // Tạo PostModel từ response và thêm vào provider
      final newPost = PostModel(
        id: widget.postProvider.generateNewPostId(),
        title: title,
        body: body,
        tags: [],
        likes: 0,
        dislikes: 0,
        views: 0,
        userId: widget.authProvider.user?.id ?? 1,
      );

      await widget.postProvider.addPost(newPost);

      // Play confetti
      _confettiController.play();

      // Clear form và ẩn
      _titleController.clear();
      _bodyController.clear();

      // Hiển thị toast thành công
      if (mounted) {
        _showSuccessToast();
      }
    } catch (e) {
      debugPrint('Error creating post: $e');
    } finally {
      if (mounted) {
        setState(() => _isCreatingPost = false);
      }
    }
  }

  void _showSuccessToast() {
    final contentStyle = context.theme.cardStyle.contentStyle.copyWith(
      titleTextStyle: context.theme.typography.sm.copyWith(
        color: context.theme.colors.primary,
        fontWeight: FontWeight.w600,
      ),
    );
    final cardStyle = context.theme.cardStyle.copyWith(
      contentStyle: contentStyle,
    );

    showRawFToast(
      context: context,
      alignment: FToastAlignment.topCenter,
      duration: const Duration(seconds: 3),
      builder: (context, toast) => Align(
        alignment: Alignment.topCenter,
        child: IntrinsicHeight(
          child: FCard(
            style: cardStyle,
            title: const Text('Đăng bài thành công'),
            subtitle: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text('Bài viết của bạn đã được hiển thị trên bảng tin.'),
            ),
            child: FButton(
              style: FButtonStyle.primary(),
              child: const Text('Đóng'),
              onPress: () => toast.dismiss(),
            ),
          ),
        ),
      ),
    );
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
      child: AnimatedBuilder(
        animation: widget.postProvider,
        builder: (context, child) {
          return Stack(
            children: [
              _buildPostsList(context),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  emissionFrequency: 0.05,
                  numberOfParticles: 30,
                  gravity: 0.2,
                  colors: const [
                    Color(0xFF4FC3F7),
                    Color(0xFF81C784),
                    Color(0xFFFFF176),
                    Color(0xFFFF8A65),
                    Color(0xFFBA68C8),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCreatePostSection(BuildContext context) {
    return FCard(
      style: (style) => style.copyWith(
        decoration: BoxDecoration(
          border: Border.all(color: context.theme.colors.border, width: 0.5),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FIcons.eggFried,
                color: context.theme.colors.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'CREATE POST',
                  style: AppFonts.bbhBartle(
                    fontSize: 20,
                    color: context.theme.colors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FTextFormField(
            controller: _titleController,
            label: Text('Tiêu đề'),
            hint: 'Nhập tiêu đề bài viết...',
            enabled: !_isCreatingPost,
            style: (style) => style.copyWith(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
          const SizedBox(height: 12),
          FTextFormField(
            controller: _bodyController,
            label: const Text('Nội dung'),
            hint: 'Nhập nội dung bài viết...',
            enabled: !_isCreatingPost,
            minLines: 3,
            maxLines: 5,
            style: (style) => style.copyWith(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          FButton(
            onPress: _isCreatingPost ? null : _handleCreatePost,
            style: FButtonStyle.primary(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: _isCreatingPost
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(FIcons.send, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Đăng bài',
                          style: AppFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsList(BuildContext context) {
    return FutureBuilder(
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
            child: Text('Lỗi: ${snapshot.error}', style: AppFonts.inter()),
          );
        }

        final List<PostModel> apiPosts = [];
        if (snapshot.hasData) {
          final response = snapshot.data!;
          final postsData = response.data['posts'] as List?;
          if (postsData != null) {
            apiPosts.addAll(
              postsData.map((json) => PostModel.fromJson(json)).toList(),
            );
          }
        }

        // Lọc user posts nếu có search query
        final List<PostModel> filteredUserPosts = _searchQuery.isEmpty
            ? widget.postProvider.userPosts
            : widget.postProvider.userPosts.where((post) {
                final query = _searchQuery.toLowerCase();
                return post.title.toLowerCase().contains(query) ||
                    post.body.toLowerCase().contains(query);
              }).toList();

        // Gộp posts của user đã lọc với posts từ API
        final allPosts = [...filteredUserPosts, ...apiPosts];

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          itemCount: _searchQuery.isEmpty
              ? allPosts.length + 1
              : allPosts.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (_searchQuery.isEmpty) {
              if (index == 0) {
                return _buildCreatePostSection(context);
              }
              final post = allPosts[index - 1];
              return _buildPostCard(post);
            } else {
              final post = allPosts[index];
              return _buildPostCard(post);
            }
          },
        );
      },
    );
  }

  Widget _buildPostCard(PostModel post) {
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
        final isUserPost = widget.postProvider.userPosts.any(
          (p) => p.id == post.id,
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                PostDetailScreen(post: post, isUserPost: isUserPost),
          ),
        );
      },
    );
  }
}
