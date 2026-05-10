import 'package:hn_reader/core/constants/constants.dart';
import 'package:hn_reader/core/errors/failures.dart';
import 'package:hn_reader/core/utils/result.dart';
import 'package:hn_reader/domain/entities/story_entity.dart';
import 'package:hn_reader/domain/repositories/story_repository.dart';
import 'package:hn_reader/presentation/features/stories/providers/story_feed_type.dart';

/// Use case: fetch a paginated page of stories for any [StoryFeedType].
///
/// Returns [Result<T>] throughout — no try/catch needed in the notifier.
///
/// ## ID caching
/// Call [fetchIds] once on feed switch, then pass [cachedIds] to [call]
/// on every subsequent page to avoid re-fetching the same ID list.
class GetStoriesByFeedUseCase {
  const GetStoriesByFeedUseCase(this._repository);

  final StoryRepository _repository;

  /// Returns a single page of stories.
  ///
  /// If [cachedIds] is null the ID list is fetched from the network first.
  Future<Result<List<StoryEntity>>> call({
    required StoryFeedType feedType,
    required int page,
    List<int>? cachedIds,
  }) async {
    // Resolve IDs (from cache or network).
    final List<int> ids;
    if (cachedIds != null) {
      ids = cachedIds;
    } else {
      final idsResult = await fetchIds(feedType);
      switch (idsResult) {
        case Err(:final failure):
          return Err(failure);
        case Ok(:final value):
          ids = value;
      }
    }

    final start = page * AppConstants.storiesPageSize;
    if (start >= ids.length) return const Ok([]);

    final end = (start + AppConstants.storiesPageSize).clamp(0, ids.length);
    return _repository.getStories(ids.sublist(start, end));
  }

  /// Fetches the ranked ID list for [feedType].
  Future<Result<List<int>>> fetchIds(StoryFeedType feedType) {
    return switch (feedType) {
      StoryFeedType.top => _repository.getTopStoryIds(),
      StoryFeedType.best => _repository.getBestStoryIds(),
      StoryFeedType.newStories => _repository.getNewStoryIds(),
      StoryFeedType.ask => _repository.getAskStoryIds(),
      StoryFeedType.show => _repository.getShowStoryIds(),
    };
  }
}
