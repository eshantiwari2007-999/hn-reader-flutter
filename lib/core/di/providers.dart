import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hn_reader/core/network/api_client.dart';
import 'package:hn_reader/data/datasources/hn_local_datasource.dart';
import 'package:hn_reader/data/datasources/hn_remote_datasource.dart';
import 'package:hn_reader/data/repositories/comment_repository_impl.dart';
import 'package:hn_reader/data/repositories/story_repository_impl.dart';
import 'package:hn_reader/domain/repositories/comment_repository.dart';
import 'package:hn_reader/domain/repositories/story_repository.dart';
import 'package:hn_reader/domain/usecases/usecases.dart';

// =============================================================================
// Core Infrastructure Providers
// =============================================================================

/// Provides the singleton [ApiClient] (Dio wrapper).
///
/// This is a lazy singleton – created once on first access and reused.
final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(),
  name: 'apiClientProvider',
);

// =============================================================================
// Data Source Providers
// =============================================================================

/// Provides the synchronous [HnLocalDataSource] initialized in main.
final hnLocalDataSourceProvider = Provider<HnLocalDataSource>((ref) {
  throw UnimplementedError('hnLocalDataSourceProvider must be overridden in main');
});

/// Provides the [HnRemoteDataSource] with its [ApiClient] dependency.
final hnRemoteDataSourceProvider = Provider<HnRemoteDataSource>(
  (ref) => HnRemoteDataSource(apiClient: ref.read(apiClientProvider)),
  name: 'hnRemoteDataSourceProvider',
);

// =============================================================================
// Repository Providers
// =============================================================================

/// Provides the [StoryRepository] domain interface (implemented by [StoryRepositoryImpl]).
final storyRepositoryProvider = Provider<StoryRepository>(
  (ref) => StoryRepositoryImpl(
    remoteDataSource: ref.read(hnRemoteDataSourceProvider),
    localDataSource: ref.read(hnLocalDataSourceProvider),
  ),
  name: 'storyRepositoryProvider',
);

/// Provides the [CommentRepository] domain interface (implemented by [CommentRepositoryImpl]).
final commentRepositoryProvider = Provider<CommentRepository>(
  (ref) => CommentRepositoryImpl(
    remoteDataSource: ref.read(hnRemoteDataSourceProvider),
    localDataSource: ref.read(hnLocalDataSourceProvider),
  ),
  name: 'commentRepositoryProvider',
);

// =============================================================================
// Use Case Providers
// =============================================================================

/// Provides [GetStoriesByFeedUseCase] for paginated multi-feed story fetching.
///
/// Used by [StoriesNotifier] to load any feed type with page-level caching.
final getStoriesByFeedUseCaseProvider = Provider<GetStoriesByFeedUseCase>(
  (ref) => GetStoriesByFeedUseCase(ref.read(storyRepositoryProvider)),
  name: 'getStoriesByFeedUseCaseProvider',
);

/// Provides [GetTopStoriesUseCase] for fetching paginated top stories.
final getTopStoriesUseCaseProvider = Provider<GetTopStoriesUseCase>(
  (ref) => GetTopStoriesUseCase(ref.read(storyRepositoryProvider)),
  name: 'getTopStoriesUseCaseProvider',
);

/// Provides [GetStoryDetailsUseCase] for fetching a single story by ID.
///
/// Used by the comments screen when navigating via deep link (no StoryEntity
/// in GoRouter `extra`).
final getStoryDetailsUseCaseProvider = Provider<GetStoryDetailsUseCase>(
  (ref) => GetStoryDetailsUseCase(ref.read(storyRepositoryProvider)),
  name: 'getStoryDetailsUseCaseProvider',
);

/// Provides [GetCommentsUseCase] for recursively fetching comment trees.
final getCommentsUseCaseProvider = Provider<GetCommentsUseCase>(
  (ref) => GetCommentsUseCase(ref.read(commentRepositoryProvider)),
  name: 'getCommentsUseCaseProvider',
);
