import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/models/post_model.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/home/widgets/comments_list.dart';
import 'package:network/presentation/home/widgets/post_card_details.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;

  const PostDetailScreen({super.key, required this.post});

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
          'Chi tiết bài viết',
          style: AppFonts.bbhBartle(fontSize: 40),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            PostCardDetails(
              id: post.id,
              title: post.title,
              body: post.body,
              tags: post.tags,
              likes: post.likes,
              dislikes: post.dislikes,
              views: post.views,
              userId: post.userId,
            ),
            const SizedBox(height: 12),
            CommentsList(postId: post.id),
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
