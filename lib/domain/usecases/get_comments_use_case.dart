import 'package:hn_reader/core/utils/result.dart';
import 'package:hn_reader/domain/entities/comment_entity.dart';
import 'package:hn_reader/domain/repositories/comment_repository.dart';

/// Use case: recursively fetch the full comment tree for a story.
///
/// Returns [Result<List<CommentEntity>>] — the notifier pattern-matches
/// instead of catching exceptions.
class GetCommentsUseCase {
  const GetCommentsUseCase(this._repository);

  final CommentRepository _repository;

  /// Fetches all top-level comments for [kidIds] (the story's `kids` list).
  ///
  /// Returns [Ok([])] immediately for empty [kidIds].
  Future<Result<List<CommentEntity>>> call(List<int> kidIds) {
    if (kidIds.isEmpty) return Future.value(const Ok([]));
    return _repository.getComments(kidIds);
  }

  /// Fetches a single comment and its subtree by [commentId].
  Future<Result<CommentEntity>> fetchOne(int commentId, {int depth = 0}) =>
      _repository.getComment(commentId, depth: depth);
}
