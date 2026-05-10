import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hn_reader/domain/entities/comment_entity.dart';
import 'package:hn_reader/domain/entities/hn_item_type.dart';
import 'package:hn_reader/domain/entities/story_entity.dart';

part 'hn_item_model.freezed.dart';
part 'hn_item_model.g.dart';

/// Unified data-layer model for **every** Hacker News item.
///
/// ## Why a single model?
/// The HN Firebase API exposes a single endpoint for all item types:
/// ```
/// GET https://hacker-news.firebaseio.com/v0/item/{id}.json
/// ```
/// The response schema is polymorphic – the `type` field (`"story"`,
/// `"comment"`, `"job"`, `"poll"`, `"pollopt"`) determines which fields
/// are populated. Using one unified model avoids:
///   - Duplicate HTTP/parsing code for each type
///   - Conditional deserialization logic scattered across the data layer
///   - Impedance mismatch when the API returns an item of an unexpected type
///
/// ## Mapper pattern
/// [HnItemModel] is **never exposed beyond the data layer**. The repository
/// calls the appropriate `toXxxEntity()` extension method to convert to a
/// domain entity. This enforces the dependency rule:
/// ```
///   Data layer  →  Domain interfaces
///   Domain      →  Nothing (pure Dart)
/// ```
///
/// ## Nullable fields
/// Every field that is conditionally present in the API is declared nullable.
/// The repository handles missing fields gracefully rather than throwing.
///
/// ## Generated files
///  - `hn_item_model.freezed.dart` – Freezed immutability + equality
///  - `hn_item_model.g.dart`       – JsonSerializable fromJson/toJson
///
/// API reference: https://github.com/HackerNews/API#items
@freezed
class HnItemModel with _$HnItemModel {
  const factory HnItemModel({
    // ── Identifier (always present) ───────────────────────────────────────

    /// The item's unique HN id. Never null.
    required int id,

    // ── Type discriminator (always present for live items) ────────────────

    /// Raw API type string: `"story"`, `"comment"`, `"job"`, `"poll"`,
    /// `"pollopt"`. Null only on deleted items where HN strips all fields.
    ///
    /// Use [itemType] getter (below) to get the typed [HnItemType] enum.
    @JsonKey(name: 'type') String? rawType,

    // ── Authorship (present on all non-deleted items) ─────────────────────

    /// Username of the submitter / commenter. Absent on deleted items.
    String? by,

    /// Unix epoch timestamp (seconds) of creation.
    int? time,

    // ── Story / Job / Poll fields ─────────────────────────────────────────

    /// Headline of a story, job listing, or poll.
    /// Always present on story-like items. Absent on comments.
    String? title,

    /// External URL linked by a story. Absent on Ask HN / text posts.
    String? url,

    /// HTML-encoded body text.
    /// Present on: Ask HN, Show HN, Job, Comment, Poll description.
    String? text,

    /// Upvote score. Present on stories, polls, and pollopts.
    int? score,

    /// Total comment count (all descendants). Present on stories and polls.
    int? descendants,

    // ── Tree structure ────────────────────────────────────────────────────

    /// IDs of direct child comments or poll options.
    @Default([]) List<int> kids,

    /// ID of the parent item. Present on comments and pollopts.
    int? parent,

    // ── Poll-specific ─────────────────────────────────────────────────────

    /// For `pollopt` items: ID of the associated poll.
    int? poll,

    /// For `poll` items: ordered list of [pollopt] item IDs.
    @Default([]) List<int> parts,

    // ── Moderation flags ──────────────────────────────────────────────────

    /// True if the item has been deleted. When true, most other fields
    /// will be absent from the API response.
    @Default(false) bool deleted,

    /// True if the item has been flagged as dead (hidden from the front page
    /// but still accessible by direct URL).
    @Default(false) bool dead,
  }) = _HnItemModel;

  /// Deserializes a raw JSON map from the HN Firebase API.
  factory HnItemModel.fromJson(Map<String, dynamic> json) =>
      _$HnItemModelFromJson(json);
}

// =============================================================================
// Extension: Typed accessors + Mapper methods
// =============================================================================

extension HnItemModelMapper on HnItemModel {
  // ---------------------------------------------------------------------------
  // Typed accessors
  // ---------------------------------------------------------------------------

  /// The resolved [HnItemType] enum value.
  ///
  /// Converts the raw `type` string once; never throws on unknown values.
  HnItemType get itemType => HnItemType.fromString(rawType);

  /// True if this item is a story, ask, show, job, or poll.
  bool get isStoryLike => itemType.isStoryLike;

  /// True if this item is a comment.
  bool get isComment => itemType == HnItemType.comment;

  // ---------------------------------------------------------------------------
  // Mapper: → StoryEntity
  // ---------------------------------------------------------------------------

  /// Converts this model to a domain [StoryEntity].
  ///
  /// Should only be called when [isStoryLike] is true.
  /// Falls back gracefully for partially populated items (e.g. deleted stories).
  StoryEntity toStoryEntity() {
    return StoryEntity(
      id: id,
      by: by ?? '[deleted]',
      time: time ?? 0,
      type: itemType,
      title: title ?? '',
      url: url,
      text: text,
      score: score ?? 0,
      descendants: descendants ?? 0,
      kids: kids,
      deleted: deleted,
      dead: dead,
    );
  }

  // ---------------------------------------------------------------------------
  // Mapper: → CommentEntity
  // ---------------------------------------------------------------------------

  /// Converts this model to a domain [CommentEntity].
  ///
  /// [depth] is set by the caller (repository) during recursive resolution.
  /// [children] are pre-resolved child entities passed in by the repository.
  CommentEntity toCommentEntity({
    int depth = 0,
    List<CommentEntity> children = const [],
  }) {
    return CommentEntity(
      id: id,
      time: time ?? 0,
      by: by ?? '[deleted]',
      text: text ?? '',
      parent: parent,
      kids: kids,
      children: children,
      depth: depth,
      deleted: deleted,
      dead: dead,
    );
  }

  // ---------------------------------------------------------------------------
  // Smart dispatcher
  // ---------------------------------------------------------------------------

  /// Converts this model to the most appropriate domain entity.
  ///
  /// Returns a [StoryEntity] for story-like items and a [CommentEntity]
  /// for comments. Throws [UnsupportedError] for unsupported types
  /// (poll options, unknown) so the caller is forced to handle them.
  ///
  /// Usage in the repository:
  /// ```dart
  /// final entity = model.toEntity();
  /// ```
  Object toEntity() {
    if (isStoryLike) return toStoryEntity();
    if (isComment) return toCommentEntity();
    throw UnsupportedError(
      'Cannot auto-map HnItemModel of type "${itemType.apiValue}" to a domain entity. '
      'Use toStoryEntity() or toCommentEntity() explicitly.',
    );
  }
}
