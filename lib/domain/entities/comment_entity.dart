import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_entity.freezed.dart';

/// Domain entity representing a single node in the HN comment tree.
///
/// ## Recursive tree structure
/// The HN API returns only **direct child IDs** in the `kids` array.
/// [CommentRepository] resolves the full tree recursively, populating
/// [children] with fully resolved [CommentEntity] objects.
///
/// The [depth] field is set by the repository during resolution.
/// It drives indentation in the UI without any extra logic in widgets.
///
/// ## HTML content
/// The `text` field contains **raw HTML** as returned by the HN API.
/// It should be rendered via `flutter_html`, not as plain text.
///
/// ## Deleted / dead comments
/// HN sometimes returns placeholder items with `deleted: true` or
/// `dead: true` and an empty `by`/`text`. The repository filters
/// these before returning, but the fields are present for safety.
@freezed
class CommentEntity with _$CommentEntity {
  const factory CommentEntity({
    // ── Required ──────────────────────────────────────────────────────────

    /// Unique HN item ID for this comment.
    required int id,

    /// Unix timestamp of when the comment was posted.
    required int time,

    // ── Author & content ──────────────────────────────────────────────────

    /// Username of the commenter. Defaults to `[deleted]` for removed items.
    @Default('[deleted]') String by,

    /// HTML-encoded comment body. Empty string for deleted comments.
    @Default('') String text,

    // ── Tree navigation ───────────────────────────────────────────────────

    /// ID of the parent item (story ID or parent comment ID).
    int? parent,

    /// IDs of direct child comments as returned by the HN API.
    @Default([]) List<int> kids,

    /// Fully resolved child [CommentEntity] objects.
    ///
    /// Populated recursively by [CommentRepository.getComments].
    /// Empty list if the comment has no children or has not been resolved.
    @Default([]) List<CommentEntity> children,

    // ── Position in tree ─────────────────────────────────────────────────

    /// Zero-indexed nesting depth.
    ///
    /// - `0` = top-level comment on a story
    /// - `1` = reply to a top-level comment
    /// - etc.
    ///
    /// Set by the repository during recursive resolution.
    /// Drives indentation width: `depth * AppConstants.commentIndentWidth`.
    @Default(0) int depth,

    // ── Moderation flags ─────────────────────────────────────────────────

    /// True if the comment was removed by the author or HN moderators.
    @Default(false) bool deleted,

    /// True if the comment has been flagged as dead (shadow-banned).
    @Default(false) bool dead,
  }) = _CommentEntity;

  // Private constructor required by Freezed for custom getters.
  const CommentEntity._();

  // ---------------------------------------------------------------------------
  // Derived properties
  // ---------------------------------------------------------------------------

  /// True if this comment should be shown in the UI.
  ///
  /// Deleted or dead comments with no text are hidden; however, if a
  /// deleted comment still has living children we may still need to render
  /// a placeholder to maintain tree structure.
  bool get isVisible => !deleted && !dead && text.isNotEmpty;

  /// True if this comment has at least one resolved child.
  bool get hasChildren => children.isNotEmpty;

  /// Total number of comments in the subtree rooted at this node
  /// (excluding this comment itself).
  int get subtreeCount => _countSubtree(this);

  static int _countSubtree(CommentEntity node) {
    if (node.children.isEmpty) return 0;
    return node.children.fold<int>(
      node.children.length,
      (sum, child) => sum + _countSubtree(child),
    );
  }
}
