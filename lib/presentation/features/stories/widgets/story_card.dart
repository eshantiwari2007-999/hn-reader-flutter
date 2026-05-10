import 'package:flutter/material.dart';
import 'package:hn_reader/core/theme/app_theme.dart';
import 'package:hn_reader/core/utils/app_utils.dart';
import 'package:hn_reader/core/utils/date_formatter.dart';
import 'package:hn_reader/domain/entities/story_entity.dart';

/// A single story row in the HN-style stories list.
///
/// Layout mirrors Hacker News:
///  - Rank number (grey)
///  - Title (bold, links to URL or text)
///  - Domain badge (grey, e.g. "github.com")
///  - Metadata row: score • author • time • comments count
///
/// Tapping the tile triggers [onTap] (navigate to comments).
/// Tapping the domain badge triggers [onUrlTap] (open URL).
class StoryCard extends StatelessWidget {
  const StoryCard({
    super.key,
    required this.story,
    required this.rank,
    required this.onTap,
    this.onUrlTap,
  });

  final StoryEntity story;

  /// 1-indexed rank number displayed on the left.
  final int rank;

  /// Called when the user taps the story row (opens comments).
  final VoidCallback onTap;

  /// Called when the user taps the domain badge (opens URL in browser).
  final VoidCallback? onUrlTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final domain = AppUtils.extractDomain(story.url);

    return InkWell(
      onTap: onTap,
      splashColor: AppTheme.hnOrange.withOpacity(0.08),
      highlightColor: AppTheme.hnOrange.withOpacity(0.04),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Rank number ──────────────────────────────────────────────
            SizedBox(
              width: 28,
              child: Text(
                '$rank.',
                style: textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 8),

            // ── Content column ───────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + domain badge
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 6,
                    children: [
                      Text(
                        story.title,
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                          height: 1.35,
                        ),
                      ),
                      if (domain != null)
                        GestureDetector(
                          onTap: onUrlTap,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              '($domain)',
                              style: textTheme.bodySmall?.copyWith(
                                color: AppTheme.textSecondary,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // Metadata row
                  _MetaRow(story: story),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sub-widget rendering the score / author / time / comments metadata line.
class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.story});

  final StoryEntity story;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final metaStyle = textTheme.bodySmall?.copyWith(
      color: AppTheme.textSecondary,
      fontSize: 11,
    );

    return Wrap(
      spacing: 0,
      children: [
        // Score
        _MetaChip(
          icon: Icons.arrow_upward_rounded,
          label: '${story.score} points',
          style: metaStyle,
        ),
        _MetaDot(style: metaStyle),

        // Author
        Text(story.by, style: metaStyle),
        _MetaDot(style: metaStyle),

        // Time
        Text(DateFormatter.timeAgo(story.time), style: metaStyle),
        _MetaDot(style: metaStyle),

        // Comment count
        _MetaChip(
          icon: Icons.mode_comment_outlined,
          label: '${story.descendants} comments',
          style: metaStyle,
        ),
      ],
    );
  }
}

class _MetaDot extends StatelessWidget {
  const _MetaDot({this.style});
  final TextStyle? style;

  @override
  Widget build(BuildContext context) =>
      Text('  ·  ', style: style?.copyWith(color: AppTheme.threadLine));
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    this.style,
  });

  final IconData icon;
  final String label;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 10, color: AppTheme.textSecondary),
        const SizedBox(width: 2),
        Text(label, style: style),
      ],
    );
  }
}
