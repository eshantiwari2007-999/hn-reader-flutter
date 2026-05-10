import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hn_reader/core/theme/app_theme.dart';
import 'package:hn_reader/core/utils/app_utils.dart';
import 'package:hn_reader/core/utils/date_formatter.dart';
import 'package:hn_reader/domain/entities/story_entity.dart';
import 'package:hn_reader/presentation/features/comments/providers/comments_provider.dart';
import 'package:hn_reader/presentation/features/comments/widgets/comment_tile.dart';
import 'package:hn_reader/presentation/widgets/hn_empty_widget.dart';
import 'package:hn_reader/presentation/widgets/hn_error_widget.dart';
import 'package:hn_reader/presentation/widgets/hn_loading_widget.dart';

/// The comments screen for a single HN story.
///
/// Displays:
///  1. A story header (title, URL, score, author, time, comment count)
///  2. The optional self-text (for Ask HN / Show HN posts)
///  3. The full nested comment tree
///
/// Receives the [StoryEntity] via GoRouter `extra` parameter so the header
/// can be rendered instantly with no additional network call.
class CommentsScreen extends ConsumerStatefulWidget {
  const CommentsScreen({
    super.key,
    required this.storyId,
    required this.story,
  });

  final int storyId;
  final StoryEntity story;

  @override
  ConsumerState<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends ConsumerState<CommentsScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger comment loading as soon as the screen is mounted.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(commentsProvider(widget.storyId).notifier)
          .loadComments(widget.story.kids);
    });
  }

  @override
  Widget build(BuildContext context) {
    final commentsState = ref.watch(commentsProvider(widget.storyId));
    final story = widget.story;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${story.descendants} comments',
          style: const TextStyle(
            fontFamily: 'Verdana',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (story.url != null)
            IconButton(
              icon: const Icon(Icons.open_in_browser_rounded, size: 20),
              tooltip: 'Open in browser',
              onPressed: () => _launchUrl(story.url!),
            ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // ── Story header ───────────────────────────────────────────────
          SliverToBoxAdapter(child: _StoryHeader(story: story)),

          // ── Comment section ────────────────────────────────────────────
          _buildCommentSection(commentsState),
        ],
      ),
    );
  }

  Widget _buildCommentSection(CommentsState state) {
    // Loading: show shimmer placeholders shaped like comment tiles.
    if (state.isLoading) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: HnCommentShimmer(
          itemCount: widget.story.descendants.clamp(1, 8),
        ),
      );
    }

    if (state.hasError) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: HnErrorWidget(
          message: state.error!,
          onRetry: () => ref
              .read(commentsProvider(widget.storyId).notifier)
              .loadComments(widget.story.kids),
        ),
      );
    }

    if (state.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: HnEmptyWidget(
          message: 'No comments yet. Be the first!',
          icon: Icons.chat_bubble_outline_rounded,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => CommentTile(
          key: ValueKey(state.comments[index].id),
          comment: state.comments[index],
        ),
        childCount: state.comments.length,
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

// =============================================================================
// Story Header Widget
// =============================================================================

/// The sticky header at the top of the comments screen.
class _StoryHeader extends StatelessWidget {
  const _StoryHeader({required this.story});

  final StoryEntity story;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final domain = AppUtils.extractDomain(story.url);

    return Container(
      color: AppTheme.surfaceVariant,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            story.title,
            style: textTheme.titleMedium?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),

          // Domain
          if (domain != null) ...[
            const SizedBox(height: 4),
            GestureDetector(
              onTap: story.url != null
                  ? () => _launchUrl(story.url!)
                  : null,
              child: Text(
                domain,
                style: textTheme.bodySmall?.copyWith(
                  color: AppTheme.hnOrange,
                  decoration: TextDecoration.underline,
                  decorationColor: AppTheme.hnOrange,
                ),
              ),
            ),
          ],
          const SizedBox(height: 8),

          // Metadata
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              _chip(
                  context, '▲ ${story.score}', AppTheme.hnOrange),
              _chip(context, 'by ${story.by}',
                  AppTheme.textSecondary),
              _chip(context,
                  DateFormatter.timeAgo(story.time), AppTheme.textSecondary),
              _chip(context, '${story.descendants} comments',
                  AppTheme.textSecondary),
            ],
          ),

          // Self text (Ask HN / Show HN)
          if (story.text != null && story.text!.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 10),
            Html(
              data: story.text!,
              style: {
                'body': Style(
                  fontSize: FontSize(13),
                  fontFamily: 'Verdana',
                  color: AppTheme.textPrimary,
                  lineHeight: LineHeight(1.5),
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                ),
                'a': Style(
                  color: AppTheme.hnOrange,
                  textDecoration: TextDecoration.none,
                ),
              },
            ),
          ],

          const SizedBox(height: 4),
          const Divider(height: 1, thickness: 1),
        ],
      ),
    );
  }

  Widget _chip(BuildContext context, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontSize: 11,
            ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
