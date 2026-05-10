/// Represents the `type` field returned by the Hacker News API for every item.
///
/// The same `/item/{id}.json` endpoint is used for all item types.
/// This enum lives in the **domain layer** so business logic can do
/// exhaustive `switch` matching without touching raw strings.
///
/// API reference: https://github.com/HackerNews/API#items
enum HnItemType {
  /// A standard story submission (has title + optional URL).
  story,

  /// A text-only question posted to the community (title starts with "Ask HN:").
  ask,

  /// A project or demo shared with the community (title starts with "Show HN:").
  show,

  /// A job listing posted by a company.
  job,

  /// A poll with multiple options.
  poll,

  /// A single option inside a poll.
  pollopt,

  /// A comment (on a story, poll, or another comment).
  comment,

  /// Fallback for any unknown/future type returned by the API.
  unknown;

  // ---------------------------------------------------------------------------
  // Factory
  // ---------------------------------------------------------------------------

  /// Converts the raw API string into the corresponding [HnItemType].
  ///
  /// Returns [HnItemType.unknown] for unrecognised values so the app
  /// never crashes on unexpected API changes.
  static HnItemType fromString(String? value) {
    switch (value) {
      case 'story':
        return HnItemType.story;
      case 'ask':
        return HnItemType.ask;
      case 'show':
        return HnItemType.show;
      case 'job':
        return HnItemType.job;
      case 'poll':
        return HnItemType.poll;
      case 'pollopt':
        return HnItemType.pollopt;
      case 'comment':
        return HnItemType.comment;
      default:
        return HnItemType.unknown;
    }
  }

  // ---------------------------------------------------------------------------
  // Convenience helpers
  // ---------------------------------------------------------------------------

  /// The raw string as returned by the HN API.
  String get apiValue {
    switch (this) {
      case HnItemType.story:
        return 'story';
      case HnItemType.ask:
        return 'ask';
      case HnItemType.show:
        return 'show';
      case HnItemType.job:
        return 'job';
      case HnItemType.poll:
        return 'poll';
      case HnItemType.pollopt:
        return 'pollopt';
      case HnItemType.comment:
        return 'comment';
      case HnItemType.unknown:
        return 'unknown';
    }
  }

  /// Human-readable label for display in the UI (e.g. tab badges).
  String get displayLabel {
    switch (this) {
      case HnItemType.story:
        return 'Story';
      case HnItemType.ask:
        return 'Ask HN';
      case HnItemType.show:
        return 'Show HN';
      case HnItemType.job:
        return 'Job';
      case HnItemType.poll:
        return 'Poll';
      case HnItemType.pollopt:
        return 'Poll Option';
      case HnItemType.comment:
        return 'Comment';
      case HnItemType.unknown:
        return 'Unknown';
    }
  }

  /// True for item types that render as a navigable story row.
  bool get isStoryLike =>
      this == HnItemType.story ||
      this == HnItemType.ask ||
      this == HnItemType.show ||
      this == HnItemType.job ||
      this == HnItemType.poll;

  /// True if this item type has a comment thread.
  bool get hasComments =>
      this == HnItemType.story ||
      this == HnItemType.ask ||
      this == HnItemType.show ||
      this == HnItemType.poll;
}
