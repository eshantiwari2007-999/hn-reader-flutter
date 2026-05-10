import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hn_reader/domain/entities/hn_item_type.dart';
import 'package:hn_reader/domain/entities/story_entity.dart';

part 'story_model.freezed.dart';
part 'story_model.g.dart';

/// A focused data model for story-like HN items.
///
/// ## Role in the architecture
/// While [HnItemModel] is the primary model used by [HnRemoteDataSource]
/// (it matches the full API response), [StoryModel] provides a **typed,
/// cleaned view** of story data. It is most useful when you want to:
///   - Cache stories independently from comments in a local database.
///   - Pass story data between widgets via serialization (e.g. deep links).
///   - Generate mock data in tests without the noise of nullable poll fields.
///
/// ## Key difference from `HnItemModel`
/// All story-specific fields (`title`, `score`, `descendants`) are
/// **non-nullable** here with sensible defaults. The `type` field uses
/// the typed [HnItemType] enum, not a raw string.
///
/// ## Serialization
/// `@JsonKey(name: 'type')` maps the raw API string to [HnItemType] via
/// a custom converter defined in [_HnItemTypeConverter].
///
/// Generated files:
///  - `story_model.freezed.dart` – Freezed immutability + equality
///  - `story_model.g.dart`       – JsonSerializable fromJson/toJson
@freezed
class StoryModel with _$StoryModel {
  const factory StoryModel({
    /// Unique HN item ID.
    required int id,

    /// Username of the submitter.
    @Default('[deleted]') String by,

    /// Unix timestamp of submission.
    @Default(0) int time,

    /// Item type (story / ask / show / job / poll).
    @Default(HnItemType.story)
    @JsonKey(name: 'type', fromJson: _hnItemTypeFromJson, toJson: _hnItemTypeToJson)
    HnItemType type,

    /// Story headline.
    @Default('') String title,

    /// External URL (null for Ask HN / text posts).
    String? url,

    /// HTML body text (Ask HN, Show HN, Job listings).
    String? text,

    /// Upvote score.
    @Default(0) int score,

    /// Total comment count.
    @Default(0) int descendants,

    /// Direct child comment IDs.
    @Default([]) List<int> kids,

    /// Soft-delete flag.
    @Default(false) bool deleted,

    /// Dead/flagged flag.
    @Default(false) bool dead,
  }) = _StoryModel;

  /// Deserializes from HN API JSON.
  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}

// =============================================================================
// HnItemType JSON helpers (top-level functions required by json_serializable)
// =============================================================================

HnItemType _hnItemTypeFromJson(String? value) =>
    HnItemType.fromString(value);

String _hnItemTypeToJson(HnItemType type) => type.apiValue;

// =============================================================================
// Mapper extension
// =============================================================================

/// Extension to convert [StoryModel] → domain [StoryEntity].
extension StoryModelMapper on StoryModel {
  /// Maps this model to a pure domain [StoryEntity].
  ///
  /// All fields are copied 1:1; no business logic lives here.
  /// Business rules belong in the domain layer or use-case classes.
  StoryEntity toEntity() => StoryEntity(
        id: id,
        by: by,
        time: time,
        type: type,
        title: title,
        url: url,
        text: text,
        score: score,
        descendants: descendants,
        kids: kids,
        deleted: deleted,
        dead: dead,
      );
}
