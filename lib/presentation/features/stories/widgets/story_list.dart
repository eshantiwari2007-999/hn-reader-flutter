import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hn_reader/core/theme/app_theme.dart';
import 'package:hn_reader/domain/entities/story_entity.dart';
import 'package:hn_reader/presentation/features/stories/providers/stories_provider.dart';
import 'package:hn_reader/presentation/features/stories/widgets/story_card.dart';
import 'package:hn_reader/presentation/widgets/hn_empty_widget.dart';
import 'package:hn_reader/presentation/widgets/hn_error_widget.dart';
import 'package:hn_reader/presentation/widgets/hn_loading_widget.dart';

/// The paginated list of stories rendered on the home screen.
///
/// Handles all three UI states internally (loading / error / content)
/// and triggers [StoriesNotifier.loadMore] when the user reaches the
/// bottom of the list (infinite scroll).
///
/// Uses [HnShimmerList] for the initial loading state to give a premium
/// skeleton loading experience instead of a plain spinner.
class StoryList extends ConsumerStatefulWidget {
  const StoryList({super.key});

  @override
  ConsumerState<StoryList> createState() => _StoryListState();
}

class _StoryListState extends ConsumerState<StoryList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  /// Triggers pagination when the user scrolls within 300px of the bottom.
  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final threshold =
        _scrollController.position.maxScrollExtent - 300;
    if (_scrollController.offset >= threshold) {
      ref.read(storiesProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(storiesProvider);

    // ── Initial full-screen shimmer loading ───────────────────────────────
    if (state.isLoading && state.stories.isEmpty) {
      return const HnShimmerList(itemCount: 12);
    }

    // ── Full-screen error (no stories loaded yet) ─────────────────────────
    if (state.error != null && state.stories.isEmpty) {
      return HnErrorWidget(
        message: state.error!,
        onRetry: () => ref.read(storiesProvider.notifier).refresh(),
      );
    }

    // ── Empty state ───────────────────────────────────────────────────────
    if (state.stories.isEmpty) {
      return const HnEmptyWidget(message: 'No stories found.');
    }

    // ── Story list ────────────────────────────────────────────────────────
    return RefreshIndicator(
      color: AppTheme.hnOrange,
      onRefresh: () => ref.read(storiesProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: state.stories.length + (state.isLoadingMore ? 1 : 0),
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          // Footer loader during pagination
          if (index == state.stories.length) {
            return const HnListFooterLoader();
          }

          final story = state.stories[index];
          final rank = index + 1;

          return StoryCard(
            story: story,
            rank: rank,
            onTap: () => _navigateToComments(context, story),
            onUrlTap: story.url != null
                ? () => _launchUrl(story.url!)
                : null,
          );
        },
      ),
    );
  }

  void _navigateToComments(BuildContext context, StoryEntity story) {
    // Pass the full StoryEntity as GoRouter `extra` so the comments screen
    // can render the header immediately without a second network round-trip.
    context.push('/story/${story.id}', extra: story);
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
