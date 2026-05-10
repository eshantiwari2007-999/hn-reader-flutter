import 'package:hn_reader/core/constants/constants.dart';
import 'package:hn_reader/core/errors/exceptions.dart';
import 'package:hn_reader/core/utils/result.dart';
import 'package:hn_reader/data/datasources/hn_local_datasource.dart';
import 'package:hn_reader/data/datasources/hn_remote_datasource.dart';
import 'package:hn_reader/domain/entities/comment_entity.dart';
import 'package:hn_reader/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  CommentRepositoryImpl({
    required HnRemoteDataSource remoteDataSource,
    required HnLocalDataSource localDataSource,
  })  : _remote = remoteDataSource,
        _local = localDataSource;

  final HnRemoteDataSource _remote;
  final HnLocalDataSource _local;

  // ---------------------------------------------------------------------------
  // Public API — Result-based
  // ---------------------------------------------------------------------------

  @override
  Future<Result<List<CommentEntity>>> getComments(
    List<int> ids, {
    int depth = 0,
  }) =>
      Result.guardAsync(() => _fetchCommentsInternal(ids, depth: depth));

  @override
  Future<Result<CommentEntity>> getComment(int id, {int depth = 0}) =>
      Result.guardAsync(() => _fetchCommentInternal(id, depth: depth));

  // ---------------------------------------------------------------------------
  // Internal throwing helpers  (used for recursive calls)
  // ---------------------------------------------------------------------------

  /// Fetches all [ids] as comment entities, concurrently, at the given [depth].
  Future<List<CommentEntity>> _fetchCommentsInternal(
    List<int> ids, {
    required int depth,
  }) async {
    if (ids.isEmpty) return const [];
    final futures = ids.map((id) => _fetchCommentSafe(id, depth: depth));
    final results = await Future.wait(futures);
    return results.whereType<CommentEntity>().toList();
  }

  /// Fetches a single comment and recursively resolves its children.
  Future<CommentEntity> _fetchCommentInternal(int id, {required int depth}) async {
    final item = await _remote.getItem(id).catchError((e) async {
      if (e is NetworkException) {
        final cached = await _local.getItem(id);
        if (cached != null) return cached;
      }
      throw e;
    });

    await _local.saveItem(item);

    final List<CommentEntity> children;
    if (item.kids.isNotEmpty && depth < AppConstants.maxCommentDepth) {
      children = await _fetchCommentsInternal(item.kids, depth: depth + 1);
    } else {
      children = const [];
    }

    return item.toCommentEntity(depth: depth, children: children);
  }

  /// Fetches one comment safely; returns null on any failure or if invisible.
  Future<CommentEntity?> _fetchCommentSafe(int id, {required int depth}) async {
    try {
      final entity = await _fetchCommentInternal(id, depth: depth);
      // Keep deleted/dead only if they have surviving children (tree structure).
      if (!entity.isVisible && !entity.hasChildren) return null;
      return entity;
    } catch (_) {
      return null;
    }
  }
}
