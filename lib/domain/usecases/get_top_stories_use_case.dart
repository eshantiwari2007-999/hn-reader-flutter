import 'package:hn_reader/core/constants/constants.dart';
import 'package:hn_reader/core/utils/result.dart';
import 'package:hn_reader/domain/entities/story_entity.dart';
import 'package:hn_reader/domain/repositories/story_repository.dart';

/// Use case: fetch a paginated page of top HN stories.
///
/// Convenience specialisation of [GetStoriesByFeedUseCase] for the Top feed.
class GetTopStoriesUseCase {
  const GetTopStoriesUseCase(this._repository);

  final StoryRepository _repository;

  /// Returns page [page] (zero-indexed) of top stories.
  Future<Result<List<StoryEntity>>> call({
    required int page,
    List<int>? cachedIds,
  }) async {
    final ids = cachedIds ?? switch (await _repository.getTopStoryIds()) {
      Ok(:final value) => value,
      Err(:final failure) => return Err(failure),
    };

    final start = page * AppConstants.storiesPageSize;
    if (start >= ids.length) return const Ok([]);

    final end = (start + AppConstants.storiesPageSize).clamp(0, ids.length);
    return _repository.getStories(ids.sublist(start, end));
  }

  /// Fetches only the ranked ID list (for prefetching / caching).
  Future<Result<List<int>>> fetchIds() => _repository.getTopStoryIds();
}
