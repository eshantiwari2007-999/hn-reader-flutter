import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hn_reader/domain/entities/hn_item_type.dart';

part 'story_entity.freezed.dart';

/// Domain entity representing a Hacker News story-like item.
///
/// Covers all top-level item types that appear in the story feed:
/// `story`, `ask`, `show`, `job`, `poll`.
///
/// ## Design decisions
/// - All fields match the HN Firebase API schema.
/// - `type` uses the domain [HnItemType] enum (not a raw String) so
///   callers can do exhaustive switch matching without stringly-typed checks.
/// - `kids` contains only the **direct child IDs** as returned by the API.
///   The full comment tree is resolved separately by [CommentRepository].
/// - `text` holds the **HTML-encoded body** for Ask HN / Show HN posts
///   and Job listings. The presentation layer renders it via `flutter_html`.
///
/// **This class has zero serialization dependencies** – it is a pure Dart
/// value object and belongs entirely in the domain layer.
@freezed
class StoryEntity with _$StoryEntity {
  const factory StoryEntity({
    // ── Required identifiers ──────────────────────────────────────────────

    /// Unique numeric item ID assigned by HN.
    required int id,

    /// Username of the user who submitted the story.
    required String by,

    /// Unix timestamp (seconds since epoch) of submission.
    required int time,

    /// Item type resolved from the raw API `"type"` string.
    required HnItemType type,

    // ── Story content ─────────────────────────────────────────────────────

    /// Headline / post title. Always present for story-like items.
    @Default('') String title,

    /// External URL linked by the story. Null for Ask HN / text-only posts.
    String? url,

    /// HTML-encoded body text.
    /// Populated for Ask HN (`"ask"`), Show HN (`"show"`), and job posts.
    String? text,

    // ── Engagement metrics ────────────────────────────────────────────────

    /// Total upvote points received.
    @Default(0) int score,

    /// Total number of comments in the thread (including nested replies).
    /// Corresponds to the `descendants` field in the API.
    @Default(0) int descendants,

    // ── Comment tree ──────────────────────────────────────────────────────

    /// IDs of the **direct** top-level comments on this story.
    /// Use [CommentRepository.getComments] to resolve the full tree.
    @Default([]) List<int> kids,

    // ── Metadata flags ────────────────────────────────────────────────────

    /// True if the item has been removed by HN moderators.
    @Default(false) bool deleted,

    /// True if the item has been flagged as dead (hidden from the front page).
    @Default(false) bool dead,
  }) = _StoryEntity;

  // Private constructor required by Freezed for adding methods/getters.
  const StoryEntity._();

  // ---------------------------------------------------------------------------
  // Derived properties (accessible because of the private constructor above)
  // ---------------------------------------------------------------------------

  /// Whether this story links to an external URL (not a text post).
  bool get isLink => url != null && url!.isNotEmpty;

  /// Whether this story has a body text (Ask HN / Show HN / Job).
  bool get hasText => text != null && text!.isNotEmpty;

  /// Whether this story has any comments.
  bool get hasComments => descendants > 0;

  /// A short display label based on the item type (e.g. "Ask HN", "Show HN").
  String get typeLabel => type.displayLabel;
}
