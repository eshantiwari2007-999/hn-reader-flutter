import 'package:hn_reader/core/errors/exceptions.dart';
import 'package:hn_reader/core/utils/result.dart';
import 'package:hn_reader/data/datasources/hn_local_datasource.dart';
import 'package:hn_reader/data/datasources/hn_remote_datasource.dart';
import 'package:hn_reader/domain/entities/hn_item_type.dart';
import 'package:hn_reader/domain/entities/story_entity.dart';
import 'package:hn_reader/domain/repositories/story_repository.dart';

class StoryRepositoryImpl implements StoryRepository {
  StoryRepositoryImpl({
    required HnRemoteDataSource remoteDataSource,
    required HnLocalDataSource localDataSource,
  })  : _remote = remoteDataSource,
        _local = localDataSource;

  final HnRemoteDataSource _remote;
  final HnLocalDataSource _local;

  // ---------------------------------------------------------------------------
  // ID list endpoints
  // ---------------------------------------------------------------------------

  @override
  Future<Result<List<int>>> getTopStoryIds() => _getIdsWithFallback(
        feedType: 'top',
        fetchRemote: _remote.getTopStoryIds,
      );

  @override
  Future<Result<List<int>>> getBestStoryIds() => _getIdsWithFallback(
        feedType: 'best',
        fetchRemote: _remote.getBestStoryIds,
      );

  @override
  Future<Result<List<int>>> getNewStoryIds() => _getIdsWithFallback(
        feedType: 'new',
        fetchRemote: _remote.getNewStoryIds,
      );

  @override
  Future<Result<List<int>>> getAskStoryIds() => _getIdsWithFallback(
        feedType: 'ask',
        fetchRemote: _remote.getAskStoryIds,
      );

  @override
  Future<Result<List<int>>> getShowStoryIds() => _getIdsWithFallback(
        feedType: 'show',
        fetchRemote: _remote.getShowStoryIds,
      );

  Future<Result<List<int>>> _getIdsWithFallback({
    required String feedType,
    required Future<List<int>> Function() fetchRemote,
  }) async {
    return Result.guardAsync(() async {
      try {
        final ids = await fetchRemote();
        // Cache the ids locally.
        await _local.saveStoryIds(feedType, ids);
        return ids;
      } on NetworkException {
        // Fallback to local cache if offline.
        final cachedIds = await _local.getStoryIds(feedType);
        if (cachedIds != null && cachedIds.isNotEmpty) {
          return cachedIds;
        }
        rethrow;
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Single story fetch
  // ---------------------------------------------------------------------------

  @override
  Future<Result<StoryEntity>> getStory(int id) =>
      Result.guardAsync(() async {
        try {
          final item = await _remote.getItem(id);
          if (!item.itemType.isStoryLike) {
            throw StateError(
              'Item $id has type "${item.itemType.apiValue}", expected story-like.',
            );
          }
          await _local.saveItem(item);
          return item.toStoryEntity();
        } on NetworkException {
          final cachedItem = await _local.getItem(id);
          if (cachedItem != null && cachedItem.itemType.isStoryLike) {
            return cachedItem.toStoryEntity();
          }
          rethrow;
        }
      });

  // ---------------------------------------------------------------------------
  // Batch story fetch
  // ---------------------------------------------------------------------------

  @override
  Future<Result<List<StoryEntity>>> getStories(List<int> ids) =>
      Result.guardAsync(() async {
        final futures = ids.map(_fetchStorySafe);
        final results = await Future.wait(futures);
        return results.whereType<StoryEntity>().toList();
      });

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Fetches one story safely, returning null on any failure.
  ///
  /// Silent failure keeps a single bad item from breaking an entire page.
  Future<StoryEntity?> _fetchStorySafe(int id) async {
    try {
      final item = await _remote.getItem(id);
      if (!item.isStoryLike || item.deleted || item.dead) return null;
      await _local.saveItem(item);
      return item.toStoryEntity();
    } on NetworkException {
      // If offline, check cache.
      final cached = await _local.getItem(id);
      if (cached != null && cached.isStoryLike && !cached.deleted && !cached.dead) {
        return cached.toStoryEntity();
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
