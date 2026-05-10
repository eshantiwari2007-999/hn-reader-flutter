import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hn_reader/core/theme/app_theme.dart';
import 'package:hn_reader/presentation/routing/app_router.dart';

/// Entry point of the hn_reader application.
///
/// Architecture overview:
/// ┌─────────────────────────────────────────────────────┐
/// │  Presentation  → domain interfaces (Repository)     │
/// │  Domain        → pure entities + abstractions       │
/// │  Data          → Dio / Firebase + concrete repos    │
/// │  Core          → DI, theme, network, constants      │
/// └─────────────────────────────────────────────────────┘
///
/// State management: flutter_riverpod (StateNotifier pattern)
/// Navigation:       go_router (declarative, type-safe)
/// HTTP:             dio (singleton ApiClient with interceptors)
/// Models:           freezed + json_serializable (immutable + codegen)
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hn_reader/presentation/providers/theme_provider.dart';
import 'package:hn_reader/data/datasources/hn_local_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local database for caching
  await Hive.initFlutter();
  
  // Create and initialize the local data source
  final localDataSource = HnLocalDataSource();
  await localDataSource.init();

  // Load shared preferences for theme
  final prefs = await SharedPreferences.getInstance();

  // Lock the app to portrait mode on phones.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set Android status bar to transparent so the HN orange bleeds through.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Provide the initialized dependencies synchronously to Riverpod
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        hnLocalDataSourceProvider.overrideWithValue(localDataSource),
      ],
      child: const HnReaderApp(),
    ),
  );
}

/// Root application widget.
///
/// Responsibilities:
///  - Wire [GoRouter] for navigation.
///  - Apply [AppTheme.lightTheme] globally.
///  - No business logic lives here – delegates everything to the router.
class HnReaderApp extends ConsumerWidget {
  const HnReaderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'HN Reader',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
