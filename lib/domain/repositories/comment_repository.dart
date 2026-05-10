import 'package:hn_reader/core/utils/result.dart';
import 'package:hn_reader/domain/entities/comment_entity.dart';

/// Abstract contract for the comment repository.
///
/// All methods return [Result<T>] — callers never need try/catch.
/// Implementations fetch comments from HN and recursively resolve the
/// full comment tree, applying depth tracking for UI indentation.
abstract class CommentRepository {
  /// Returns the top-level [CommentEntity] list for a story, with
  /// [CommentEntity.children] populated recursively up to
  /// [AppConstants.maxCommentDepth] levels deep.
  ///
  /// [ids] – the `kids` array from the parent story or comment.
  Future<Result<List<CommentEntity>>> getComments(
    List<int> ids, {
    int depth = 0,
  });

  /// Fetches a single [CommentEntity] by its [id].
  Future<Result<CommentEntity>> getComment(int id, {int depth = 0});
}
