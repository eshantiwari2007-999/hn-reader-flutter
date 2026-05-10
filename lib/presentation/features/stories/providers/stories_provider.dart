import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hn_reader/core/constants/constants.dart';
import 'package:hn_reader/core/di/providers.dart';
import 'package:hn_reader/core/utils/result.dart';
import 'package:hn_reader/domain/entities/story_entity.dart';
import 'package:hn_reader/domain/usecases/get_stories_by_feed_use_case.dart';
import 'package:hn_reader/presentation/features/stories/providers/story_feed_type.dart';

// =============================================================================
// State
// =============================================================================

/// Immutable state held by [StoriesNotifier].
class StoriesState {
  const StoriesState({
    this.stories = const [],
    this.allIds = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.feedType = StoryFeedType.top,
    this.currentPage = 0,
    this.hasMore = true,
  });

  final List<StoryEntity> stories;
  final List<int> allIds;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final StoryFeedType feedType;
  final int currentPage;
  final bool hasMore;

  StoriesState copyWith({
    List<StoryEntity>? stories,
    List<int>? allIds,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    bool clearError = false,
    StoryFeedType? feedType,
    int? currentPage,
    bool? hasMore,
  }) {
    return StoriesState(
      stories: stories ?? this.stories,
      allIds: allIds ?? this.allIds,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: clearError ? null : (error ?? this.error),
      feedType: feedType ?? this.feedType,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// =============================================================================
// Notifier
// =============================================================================

/// Manages the paginated story list using [GetStoriesByFeedUseCase].
///
/// ## Result handling
/// All use-case calls return [Result<T>]. The notifier pattern-matches
/// with `switch` — no try/catch needed.  Error messages come from
/// [Failure.message] via the [FailureX] extension.
class StoriesNotifier extends StateNotifier<StoriesState> {
  StoriesNotifier(this._useCase) : super(const StoriesState()) {
    _loadFeed(StoryFeedType.top);
  }

  final GetStoriesByFeedUseCase _useCase;

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  Future<void> switchFeed(StoryFeedType feedType) async {
    if (state.feedType == feedType && !state.isLoading) return;
    await _loadFeed(feedType);
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;
    await _loadPage(state.currentPage + 1);
  }

  Future<void> refresh() => _loadFeed(state.feedType);

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  Future<void> _loadFeed(StoryFeedType feedType) async {
    state = state.copyWith(
      isLoading: true,
      stories: [],
      allIds: [],
      currentPage: 0,
      hasMore: true,
      feedType: feedType,
      clearError: true,
    );

    // Step 1: fetch the ranked ID list.
    final idsResult = await _useCase.fetchIds(feedType);
    switch (idsResult) {
      case Err(:final failure):
        state = state.copyWith(isLoading: false, error: failure.message);
        return;
      case Ok(:final value):
        state = state.copyWith(allIds: value);
    }

    // Step 2: load the first page.
    await _loadPage(0);
  }

  Future<void> _loadPage(int page) async {
    state = page == 0
        ? state.copyWith(isLoading: true, clearError: true)
        : state.copyWith(isLoadingMore: true, clearError: true);

    final start = page * AppConstants.storiesPageSize;
    final end =
        (start + AppConstants.storiesPageSize).clamp(0, state.allIds.length);

    if (start >= state.allIds.length) {
      state = state.copyWith(
          isLoading: false, isLoadingMore: false, hasMore: false);
      return;
    }

    final result = await _useCase(
      feedType: state.feedType,
      page: page,
      cachedIds: state.allIds,
    );

    switch (result) {
      case Err(:final failure):
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: failure.message,
        );
      case Ok(:final value):
        state = state.copyWith(
          stories: [...state.stories, ...value],
          isLoading: false,
          isLoadingMore: false,
          currentPage: page,
          hasMore: end < state.allIds.length,
        );
    }
  }
}

// =============================================================================
// Provider
// =============================================================================

final storiesProvider =
    StateNotifierProvider<StoriesNotifier, StoriesState>(
  (ref) => StoriesNotifier(ref.read(getStoriesByFeedUseCaseProvider)),
  name: 'storiesProvider',
);
