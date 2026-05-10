/// App-wide constants for the HN Reader application.
///
/// Centralises all magic strings and numbers so they can be updated
/// in one place without hunting through the codebase.
class AppConstants {
  AppConstants._();

  // ---------------------------------------------------------------------------
  // Hacker News Firebase REST API
  // ---------------------------------------------------------------------------

  /// Base URL for the official Hacker News Firebase API (v0).
  static const String baseUrl =
      'https://hacker-news.firebaseio.com/v0';

  /// Endpoint that returns the IDs of the current top-500 stories.
  static const String topStoriesEndpoint = '/topstories.json';

  /// Endpoint that returns the IDs of the current best-500 stories.
  static const String bestStoriesEndpoint = '/beststories.json';

  /// Endpoint that returns the IDs of the current new-500 stories.
  static const String newStoriesEndpoint = '/newstories.json';

  /// Endpoint that returns the IDs of the current Ask HN stories.
  static const String askStoriesEndpoint = '/askstories.json';

  /// Endpoint that returns the IDs of the current Show HN stories.
  static const String showStoriesEndpoint = '/showstories.json';

  /// Endpoint template for fetching a single item (story/comment/user).
  /// Replace `{id}` with the actual numeric ID before use.
  static const String itemEndpoint = '/item/{id}.json';

  // ---------------------------------------------------------------------------
  // Pagination
  // ---------------------------------------------------------------------------

  /// Number of stories to load per page on the story list screen.
  static const int storiesPageSize = 20;

  // ---------------------------------------------------------------------------
  // UI / Timing
  // ---------------------------------------------------------------------------

  /// Duration (ms) for standard UI fade/slide transitions.
  static const int animationDurationMs = 250;

  /// Maximum number of comment nesting levels to render.
  static const int maxCommentDepth = 6;

  /// Indent width (logical pixels) applied per nesting level in comments.
  static const double commentIndentWidth = 12.0;

  // ---------------------------------------------------------------------------
  // Error Messages
  // ---------------------------------------------------------------------------

  static const String genericError =
      'Something went wrong. Please try again.';
  static const String networkError =
      'No internet connection. Please check your network.';
  static const String timeoutError =
      'The request timed out. Please try again.';
}
