import 'dart:math' as math;

/// General utility helpers used across the presentation layer.
class AppUtils {
  AppUtils._();

  /// Formats a large integer as a compact string.
  ///
  /// Examples:
  ///  - `999`   → `"999"`
  ///  - `1000`  → `"1k"`
  ///  - `15400` → `"15.4k"`
  static String compactNumber(int value) {
    if (value < 1000) return '$value';
    final k = value / 1000;
    return '${k.toStringAsFixed(k < 10 ? 1 : 0)}k';
  }

  /// Returns the domain name from a full URL string.
  ///
  /// Example: `"https://example.com/some/path"` → `"example.com"`
  static String? extractDomain(String? url) {
    if (url == null || url.isEmpty) return null;
    try {
      final uri = Uri.parse(url);
      return uri.host.replaceFirst('www.', '');
    } catch (_) {
      return null;
    }
  }

  /// Clamps [value] between [min] and [max] (inclusive).
  static int clamp(int value, int min, int max) =>
      math.min(math.max(value, min), max);
}
