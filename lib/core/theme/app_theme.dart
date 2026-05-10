import 'package:flutter/material.dart';

/// Application theme that mirrors the visual identity of Hacker News.
class AppTheme {
  AppTheme._();

  // ---------------------------------------------------------------------------
  // Core Colors
  // ---------------------------------------------------------------------------
  static const Color hnOrange = Color(0xFFFF6600);
  
  // Light Mode Colors
  static const Color bgLight = Color(0xFFF6F6EF);
  static const Color textPrimaryLight = Color(0xFF000000);
  static const Color textSecondaryLight = Color(0xFF828282);
  static const Color surfaceVariantLight = Color(0xFFEBECE9); // Used for code blocks / header bg
  static const Color threadLineLight = Color(0xFFD6D6D6); // Indentation line

  // Dark Mode Colors
  static const Color bgDark = Color(0xFF121212);
  static const Color textPrimaryDark = Color(0xFFE0E0E0);
  static const Color textSecondaryDark = Color(0xFF8A8A8A);
  static const Color surfaceVariantDark = Color(0xFF1E1E1E);
  static const Color threadLineDark = Color(0xFF333333);

  // Backward compatibility getters (defaults to light mode equivalents)
  static Color get background => bgLight;
  static Color get textPrimary => textPrimaryLight;
  static Color get textSecondary => textSecondaryLight;
  static Color get surfaceVariant => surfaceVariantLight;
  static Color get threadLine => threadLineLight;

  // ---------------------------------------------------------------------------
  // Light Theme
  // ---------------------------------------------------------------------------
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: hnOrange,
        primary: hnOrange,
        surface: bgLight,
        onSurface: textPrimaryLight,
      ),
      scaffoldBackgroundColor: bgLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: hnOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      dividerTheme: const DividerThemeData(
        color: surfaceVariantLight,
        thickness: 1,
        space: 1,
      ),
      // Default typography matching Hacker News
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontFamily: 'Verdana',
          fontSize: 14,
          color: textPrimaryLight,
          height: 1.3,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Verdana',
          fontSize: 11,
          color: textSecondaryLight,
          height: 1.4,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Dark Theme
  // ---------------------------------------------------------------------------
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: hnOrange,
        brightness: Brightness.dark,
        primary: hnOrange,
        surface: bgDark,
        onSurface: textPrimaryDark,
      ),
      scaffoldBackgroundColor: bgDark,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade900,
        foregroundColor: hnOrange,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: hnOrange),
      ),
      dividerTheme: const DividerThemeData(
        color: surfaceVariantDark,
        thickness: 1,
        space: 1,
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontFamily: 'Verdana',
          fontSize: 14,
          color: textPrimaryDark,
          height: 1.3,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Verdana',
          fontSize: 11,
          color: textSecondaryDark,
          height: 1.4,
        ),
      ),
    );
  }
}
