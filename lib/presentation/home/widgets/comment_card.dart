import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/models/comment_model.dart';
import 'package:network/core/theme/app_fonts.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;

  const CommentCard({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return FCard(
      style: (style) => style.copyWith(
        decoration: BoxDecoration(
          border: Border.all(color: context.theme.colors.border, width: 0.5),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info
          Row(
            children: [
              FAvatar(
                image: const AssetImage('assets/images/user.png'),
                size: 32.0,
                semanticsLabel: 'Commenter avatar',
                fallback: Text(
                  comment.username != null && comment.username!.isNotEmpty
                      ? comment.username![0].toUpperCase()
                      : 'U',
                  style: AppFonts.bbhBartle(fontSize: 14),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  comment.username ?? 'Anonymous',
                  style: AppFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Comment body
          Text(
            comment.body,
            style: AppFonts.inter(
              fontSize: 14,
              color: context.theme.colors.foreground,
            ),
          ),
        ],
      ),
    );
  }
}

