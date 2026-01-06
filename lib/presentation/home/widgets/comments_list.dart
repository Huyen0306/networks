import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/models/comment_model.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/home/services/comment_service.dart';
import 'package:network/presentation/home/widgets/comment_card.dart';

class CommentsList extends StatelessWidget {
  final int postId;
  final bool isUserPost;

  const CommentsList({
    super.key,
    required this.postId,
    this.isUserPost = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isUserPost) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Chưa có bình luận nào',
          style: AppFonts.inter(color: context.theme.colors.mutedForeground),
        ),
      );
    }

    final commentService = CommentService();

    return FutureBuilder(
      future: commentService.getCommentsByPostId(postId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FProgress(semanticsLabel: 'Loading comments'),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Lỗi: ${snapshot.error}', style: AppFonts.inter()),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final response = snapshot.data!;
        final commentsData = response.data['comments'] as List?;

        if (commentsData == null || commentsData.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Chưa có bình luận nào',
              style: AppFonts.inter(
                color: context.theme.colors.mutedForeground,
              ),
            ),
          );
        }

        final comments = commentsData
            .map((json) => CommentModel.fromJson(json))
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comments (${comments.length})',
              style: AppFonts.bbhBartle(fontSize: 20),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 0),
              itemCount: comments.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return CommentCard(comment: comments[index]);
              },
            ),
          ],
        );
      },
    );
  }
}
