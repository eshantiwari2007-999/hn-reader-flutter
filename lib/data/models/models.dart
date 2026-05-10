/// Barrel export for all data-layer models.
///
/// Consumers inside the data layer import this single file:
/// ```dart
/// import 'package:hn_reader/data/models/models.dart';
/// ```
///
/// Note: the **presentation and domain layers must never import from here**.
/// They interact exclusively through domain entities and repository interfaces.
export 'package:hn_reader/data/models/hn_item_model.dart';
export 'package:hn_reader/data/models/story_model.dart';
export 'package:hn_reader/data/models/comment_model.dart';
