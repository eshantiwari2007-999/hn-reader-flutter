import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hn_reader/domain/entities/comment_entity.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

/// A focused data model for HN comment items.
///
/// ## Role in the architecture
/// [CommentModel] represents the raw API data for a single comment node.
/// It is used by [HnRemoteDataSource] when deserializing individual comment
/// requests, and by the repository when building the recursive comment tree.
///
/// Unlike [HnItemModel] (which covers all item types), [CommentModel] only
/// carries fields meaningful to comments, making the intent explicit.
///
/// ## Children
/// The HN API only returns the **direct child IDs** (`kids`).
/// [CommentModel] does **not** contain resolved children – that is the
/// repository's responsibility. The domain [CommentEntity] holds the
/// resolved `children` list populated by [CommentRepositoryImpl].
///
/// Generated files:
///  - `comment_model.freezed.dart` – Freezed immutability + equality
///  - `comment_model.g.dart`       – JsonSerializable fromJson/toJson
@freezed
class CommentModel with _$CommentModel {
  const factory CommentModel({
    /// Unique HN item ID.
    required int id,

    /// Username of the commenter. Absent on deleted comments.
    @Default('[deleted]') String by,

    /// HTML-encoded comment body. Empty for deleted comments.
    @Default('') String text,

    /// Unix timestamp of posting.
    @Default(0) int time,

    /// ID of the parent item (story or parent comment).
    int? parent,

    /// IDs of direct child comments.
    @Default([]) List<int> kids,

    /// True if deleted by the author or HN moderators.
    @Default(false) bool deleted,

    /// True if shadow-banned / dead.
    @Default(false) bool dead,
  }) = _CommentModel;

  /// Deserializes from HN API JSON.
  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}

// =============================================================================
// Mapper extension
// =============================================================================

/// Extension to convert [CommentModel] → domain [CommentEntity].
extension CommentModelMapper on CommentModel {
  /// Maps this model to a [CommentEntity].
  ///
  /// [depth]    – Current nesting level set by the repository (0 = top-level).
  /// [children] – Recursively resolved child entities passed in by the repo.
  ///
  /// These two parameters exist **only** in the entity, not in the model,
  /// because they are derived during recursive resolution – not from the API.
  CommentEntity toEntity({
    int depth = 0,
    List<CommentEntity> children = const [],
  }) =>
      CommentEntity(
        id: id,
        time: time,
        by: by,
        text: text,
        parent: parent,
        kids: kids,
        children: children,
        depth: depth,
        deleted: deleted,
        dead: dead,
      );
}
