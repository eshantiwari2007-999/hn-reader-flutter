import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hn_reader/domain/entities/story_entity.dart';
import 'package:hn_reader/presentation/features/comments/screens/comments_screen.dart';
import 'package:hn_reader/presentation/features/stories/screens/stories_screen.dart';

/// Application router configured with [GoRouter].
///
/// Routes:
///  - `/`           → [StoriesScreen]  (Home – story list)
///  - `/story/:id`  → [CommentsScreen] (Comments for a story)
///
/// The [StoryEntity] object is passed via GoRouter's `extra` parameter
/// so the comments screen can render the header immediately without a
/// second network round-trip.
final appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    // ── Home ──────────────────────────────────────────────────────────────
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const StoriesScreen(),
    ),

    // ── Comments ──────────────────────────────────────────────────────────
    GoRoute(
      path: '/story/:id',
      name: 'comments',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);

        // `extra` carries the full [StoryEntity] passed from the story list.
        // This avoids a redundant API call just to render the header.
        final story = state.extra as StoryEntity;

        return CommentsScreen(storyId: id, story: story);
      },
    ),
  ],

  // Global error page
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Page Not Found')),
    body: Center(
      child: Text(
        'Route not found: ${state.uri}',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
  ),
);
