import 'package:intl/intl.dart';

/// Utility helpers for formatting dates and elapsed time.
///
/// Hacker News displays human-readable relative timestamps
/// (e.g. "3 hours ago", "2 days ago") instead of absolute dates.
class DateFormatter {
  DateFormatter._();

  // Date formatter for absolute dates (used in tooltips etc.)
  static final DateFormat _absoluteFormat =
      DateFormat('MMM d, yyyy  HH:mm');

  /// Returns a human-readable relative time string from a Unix epoch
  /// [timestamp] (seconds since 1970-01-01T00:00:00Z).
  ///
  /// Examples:
  ///  - `"just now"` (< 1 minute ago)
  ///  - `"5 minutes ago"`
  ///  - `"3 hours ago"`
  ///  - `"2 days ago"`
  ///  - `"Apr 3, 2024"` (older than 30 days)
  static String timeAgo(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) {
      final m = diff.inMinutes;
      return '$m ${m == 1 ? 'minute' : 'minutes'} ago';
    }
    if (diff.inHours < 24) {
      final h = diff.inHours;
      return '$h ${h == 1 ? 'hour' : 'hours'} ago';
    }
    if (diff.inDays < 30) {
      final d = diff.inDays;
      return '$d ${d == 1 ? 'day' : 'days'} ago';
    }

    // Fallback to absolute date for old items.
    return DateFormat('MMM d, yyyy').format(date);
  }

  /// Returns the full absolute date-time string for a given Unix [timestamp].
  static String absolute(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return _absoluteFormat.format(date);
  }
}
