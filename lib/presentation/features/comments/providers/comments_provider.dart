import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hn_reader/core/di/providers.dart';
import 'package:hn_reader/core/errors/failures.dart';
import 'package:hn_reader/core/utils/result.dart';
import 'package:hn_reader/domain/entities/comment_entity.dart';
import 'package:hn_reader/domain/usecases/get_comments_use_case.dart';

// =============================================================================
// State
// =============================================================================

/// Immutable state for the comments screen.
class CommentsState {
  const CommentsState({
    this.comments = const [],
    this.isLoading = false,
    this.error,
  });

  final List<CommentEntity> comments;
  final bool isLoading;
  final String? error;

  bool get hasError => error != null;
  bool get isEmpty => !isLoading && comments.isEmpty && error == null;

  CommentsState copyWith({
    List<CommentEntity>? comments,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return CommentsState(
      comments: comments ?? this.comments,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

// =============================================================================
// Notifier
// =============================================================================

/// [StateNotifier] that fetches and holds the full comment tree for a story.
///
/// ## Architecture
/// Depends on [GetCommentsUseCase] (domain layer). This keeps the
/// presentation layer decoupled from the repository implementation and
/// Dio internals.
///
/// ## Result handling
/// The use-case call returns [Result<T>]. The notifier pattern-matches
/// with `switch` — no try/catch needed. Error messages come from
/// [Failure.message] via the [FailureX] extension.
class CommentsNotifier extends StateNotifier<CommentsState> {
  CommentsNotifier(this._useCase) : super(const CommentsState());

  final GetCommentsUseCase _useCase;

  /// Loads all comments for a story, given its [kidIds] list.
  ///
  /// [kidIds] is the `kids` array from the parent [StoryEntity].
  Future<void> loadComments(List<int> kidIds) async {
    if (kidIds.isEmpty) {
      state = const CommentsState();
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true, comments: []);

    final result = await _useCase(kidIds);
    switch (result) {
      case Err(:final failure):
        state = state.copyWith(isLoading: false, error: failure.message);
      case Ok(:final value):
        state = state.copyWith(isLoading: false, comments: value);
    }
  }

  /// Clears the current comment tree (called when navigating away).
  void clear() => state = const CommentsState();
}

// =============================================================================
// Provider (family – one notifier per story ID)
// =============================================================================

/// Family provider so each story gets its own isolated [CommentsNotifier].
///
/// The dependency chain:
/// ```
/// commentsProvider(storyId)
///   → CommentsNotifier
///     → GetCommentsUseCase    (domain)
///       → CommentRepository   (domain interface)
///         → CommentRepositoryImpl (data)
/// ```
///
/// Usage:
/// ```dart
/// final state = ref.watch(commentsProvider(storyId));
/// ref.read(commentsProvider(storyId).notifier).loadComments(kids);
/// ```
final commentsProvider = StateNotifierProvider.family<CommentsNotifier,
    CommentsState, int>(
  (ref, storyId) => CommentsNotifier(ref.read(getCommentsUseCaseProvider)),
  name: 'commentsProvider',
);
