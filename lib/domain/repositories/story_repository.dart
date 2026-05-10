import 'package:hn_reader/core/utils/result.dart';
import 'package:hn_reader/domain/entities/story_entity.dart';

/// Abstract contract for the story repository.
///
/// All methods return [Result<T>] — callers never need try/catch.
/// The data layer catches domain exceptions and maps them to [Failure].
///
/// DIP: the domain layer depends only on this interface.
/// [StoryRepositoryImpl] in the data layer provides the concrete impl.
abstract class StoryRepository {
  /// Returns the IDs of the current top stories (up to 500).
  Future<Result<List<int>>> getTopStoryIds();

  /// Returns the IDs of the current best stories.
  Future<Result<List<int>>> getBestStoryIds();

  /// Returns the IDs of the current new stories.
  Future<Result<List<int>>> getNewStoryIds();

  /// Returns the IDs of the current Ask HN stories.
  Future<Result<List<int>>> getAskStoryIds();

  /// Returns the IDs of the current Show HN stories.
  Future<Result<List<int>>> getShowStoryIds();

  /// Fetches a single [StoryEntity] by [id].
  Future<Result<StoryEntity>> getStory(int id);

  /// Fetches a batch of [StoryEntity] objects for the given [ids].
  ///
  /// Partial failures are silently dropped – the overall result is always
  /// [Ok] (possibly with fewer items than requested).
  Future<Result<List<StoryEntity>>> getStories(List<int> ids);
}
