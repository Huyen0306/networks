import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/app_fonts.dart';

class PostCard extends StatelessWidget {
  final int id;
  final String title;
  final String body;
  final List<String> tags;
  final int likes;
  final int dislikes;
  final int views;
  final int userId;
  final VoidCallback? onViewDetail;

  const PostCard({
    super.key,
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.likes,
    required this.dislikes,
    required this.views,
    required this.userId,
    this.onViewDetail,
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
          // Title
          Text(
            title,
            style: AppFonts.bbhBartle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          // Body
          Text(
            body,
            style: AppFonts.inter(
              fontSize: 14,
              color: context.theme.colors.mutedForeground,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          // Tags
          if (tags.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags.take(3).map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: context.theme.colors.muted,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tag,
                    style: AppFonts.inter(
                      fontSize: 12,
                      color: context.theme.colors.mutedForeground,
                    ),
                  ),
                );
              }).toList(),
            ),
          const SizedBox(height: 12),
          // Reactions and views
          Row(
            children: [
              Icon(
                FIcons.heart,
                size: 16,
                color: context.theme.colors.mutedForeground,
              ),
              const SizedBox(width: 4),
              Text(
                '$likes',
                style: AppFonts.inter(
                  fontSize: 12,
                  color: context.theme.colors.mutedForeground,
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                FIcons.heartOff,
                size: 16,
                color: context.theme.colors.mutedForeground,
              ),
              const SizedBox(width: 4),
              Text(
                '$dislikes',
                style: AppFonts.inter(
                  fontSize: 12,
                  color: context.theme.colors.mutedForeground,
                ),
              ),
              const Spacer(),
              Icon(
                FIcons.eye,
                size: 16,
                color: context.theme.colors.mutedForeground,
              ),
              const SizedBox(width: 4),
              Text(
                '$views',
                style: AppFonts.inter(
                  fontSize: 12,
                  color: context.theme.colors.mutedForeground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // View detail button
          FButton(
            onPress: onViewDetail ?? () {},
            style: FButtonStyle.secondary(),
            child: Text(
              'Xem chi tiết',
              style: AppFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

