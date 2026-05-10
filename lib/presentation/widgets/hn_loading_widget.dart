import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:hn_reader/core/theme/app_theme.dart';

/// Full-screen (or inline) loading indicator styled to match HN orange.
///
/// Used as the initial loading state for the stories list and comments screen.
class HnLoadingWidget extends StatelessWidget {
  const HnLoadingWidget({
    super.key,
    this.message = 'Loading…',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: AppTheme.hnOrange,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}

/// Shimmer skeleton list – mimics the story card layout while data loads.
///
/// Renders [itemCount] placeholder rows with animated shimmer effect.
/// This gives a much better perceived performance than a simple spinner.
///
/// Usage:
/// ```dart
/// if (state.isLoading && state.stories.isEmpty) {
///   return const HnShimmerList();
/// }
/// ```
class HnShimmerList extends StatelessWidget {
  const HnShimmerList({
    super.key,
    this.itemCount = 10,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.surfaceVariant,
      highlightColor: Colors.white,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, __) => const _ShimmerStoryCard(),
      ),
    );
  }
}

/// A single shimmer placeholder that mirrors the layout of [StoryCard].
class _ShimmerStoryCard extends StatelessWidget {
  const _ShimmerStoryCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rank placeholder
          Container(
            width: 22,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 10),
          // Content placeholder
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title line 1
                Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 6),
                // Title line 2 (shorter)
                Container(
                  height: 14,
                  width: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 10),
                // Meta row
                Row(
                  children: [
                    _shimmerChip(60),
                    const SizedBox(width: 8),
                    _shimmerChip(80),
                    const SizedBox(width: 8),
                    _shimmerChip(50),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerChip(double width) {
    return Container(
      height: 10,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

/// Shimmer skeleton for a comment tile.
class HnCommentShimmer extends StatelessWidget {
  const HnCommentShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.surfaceVariant,
      highlightColor: Colors.white,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (_, index) => _ShimmerCommentTile(
          // Vary indent to mimic nested comments.
          indent: (index % 3) * 12.0,
        ),
      ),
    );
  }
}

class _ShimmerCommentTile extends StatelessWidget {
  const _ShimmerCommentTile({required this.indent});
  final double indent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indent, top: 10, bottom: 10, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                width: 3,
                height: 14,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Container(
                width: 80,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 50,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Body lines
          Container(
            height: 11,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 11,
            width: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 11,
            width: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact loading indicator shown at the bottom of the list
/// while additional pages are being fetched (infinite scroll footer).
class HnListFooterLoader extends StatelessWidget {
  const HnListFooterLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppTheme.hnOrange,
          ),
        ),
      ),
    );
  }
}
