/// Enum representing the different story feed categories on Hacker News.
///
/// Each value maps to a different HN API endpoint and is used by both
/// the [StoriesNotifier] and the navigation tab bar to switch feeds.
enum StoryFeedType {
  /// The classic front-page top stories (ranked by score + time).
  top,

  /// Best stories – a curated high-quality subset of top.
  best,

  /// Newest submitted stories (raw chronological order).
  newStories,

  /// Ask HN posts (text-only questions to the community).
  ask,

  /// Show HN posts (projects/demos shared with the community).
  show;

  /// Human-readable label shown in the UI tab bar.
  String get label {
    switch (this) {
      case StoryFeedType.top:
        return 'Top';
      case StoryFeedType.best:
        return 'Best';
      case StoryFeedType.newStories:
        return 'New';
      case StoryFeedType.ask:
        return 'Ask';
      case StoryFeedType.show:
        return 'Show';
    }
  }
}
