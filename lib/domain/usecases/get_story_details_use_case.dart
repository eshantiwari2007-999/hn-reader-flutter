import 'package:hn_reader/core/utils/result.dart';
import 'package:hn_reader/domain/entities/story_entity.dart';
import 'package:hn_reader/domain/repositories/story_repository.dart';

/// Use case: fetch a single story's full details by its numeric [id].
///
/// Used when navigating to comments via a deep link where only the story
/// ID is available (no [StoryEntity] in GoRouter `extra`).
class GetStoryDetailsUseCase {
  const GetStoryDetailsUseCase(this._repository);

  final StoryRepository _repository;

  /// Returns [Ok<StoryEntity>] on success or [Err<Failure>] on failure.
  Future<Result<StoryEntity>> call(int storyId) =>
      _repository.getStory(storyId);
}
