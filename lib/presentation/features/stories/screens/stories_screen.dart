import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hn_reader/core/theme/app_theme.dart';
import 'package:hn_reader/presentation/features/stories/providers/stories_provider.dart';
import 'package:hn_reader/presentation/features/stories/providers/story_feed_type.dart';
import 'package:hn_reader/presentation/features/stories/widgets/story_list.dart';
import 'package:hn_reader/presentation/providers/theme_provider.dart';

/// The home screen – Hacker News front page with feed-type tabs.
///
/// Tabs: Top · Best · New · Ask · Show
/// Each tab switches the active feed in [StoriesNotifier] without
/// rebuilding the scaffold unnecessarily.
class StoriesScreen extends ConsumerWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: StoryFeedType.values.length,
      child: Scaffold(
        appBar: AppBar(
          // HN-style title
          title: const _HnTitle(),
          actions: [
            IconButton(
              icon: Icon(
                ref.watch(themeProvider) == ThemeMode.dark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                size: 20,
              ),
              onPressed: () =>
                  ref.read(themeProvider.notifier).toggleTheme(),
              tooltip: 'Toggle Theme',
            ),
          ],
          bottom: TabBar(
            isScrollable: false,
            indicatorColor: Colors.white,
            indicatorWeight: 2.5,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(
              fontFamily: 'Verdana',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Verdana',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            onTap: (index) {
              ref
                  .read(storiesProvider.notifier)
                  .switchFeed(StoryFeedType.values[index]);
            },
            tabs: StoryFeedType.values
                .map((f) => Tab(text: f.label))
                .toList(),
          ),
        ),
        body: const StoryList(),
      ),
    );
  }
}

/// The "Y HN" logo widget in the app bar, styled after Hacker News.
class _HnTitle extends StatelessWidget {
  const _HnTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // "Y" logo box
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
          child: const Center(
            child: Text(
              'Y',
              style: TextStyle(
                fontFamily: 'Verdana',
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: AppTheme.hnOrange,
                height: 1,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Hacker News',
          style: TextStyle(
            fontFamily: 'Verdana',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
