import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hn_reader/core/constants/constants.dart';
import 'package:hn_reader/core/theme/app_theme.dart';
import 'package:hn_reader/core/utils/date_formatter.dart';
import 'package:hn_reader/domain/entities/comment_entity.dart';

/// A single comment in the nested comment tree.
///
/// Renders:
///  - Left-side coloured depth bar (indentation guide)
///  - Author name and timestamp
///  - HTML comment body (via flutter_html)
///  - Collapse / expand toggle
///  - Recursively renders child [CommentEntity] objects
class CommentTile extends StatefulWidget {
  const CommentTile({
    super.key,
    required this.comment,
  });

  final CommentEntity comment;

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile>
    with SingleTickerProviderStateMixin {
  bool _collapsed = false;

  // Depth-based colours for the indent bar – cycles after 6 levels.
  static const List<Color> _depthColors = [
    Color(0xFFFF6600), // level 0 – HN orange
    Color(0xFF5B9BD5), // level 1 – blue
    Color(0xFF70AD47), // level 2 – green
    Color(0xFFED7D31), // level 3 – amber
    Color(0xFF9B59B6), // level 4 – purple
    Color(0xFF1ABC9C), // level 5 – teal
  ];

  Color get _barColor =>
      _depthColors[widget.comment.depth % _depthColors.length];

  @override
  Widget build(BuildContext context) {
    final comment = widget.comment;

    // Skip deleted / dead comments silently.
    if (comment.deleted || comment.dead || comment.text.isEmpty) {
      return const SizedBox.shrink();
    }

    final indentLeft =
        comment.depth * AppConstants.commentIndentWidth;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(left: indentLeft),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header (author + time + collapse) ──────────────────────────
          InkWell(
            onTap: () => setState(() => _collapsed = !_collapsed),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  // Depth bar
                  Container(
                    width: 3,
                    height: 14,
                    decoration: BoxDecoration(
                      color: _barColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Author
                  Text(
                    comment.by,
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.hnOrange,
                    ),
                  ),
                  const SizedBox(width: 6),

                  // Time
                  Text(
                    DateFormatter.timeAgo(comment.time),
                    style: textTheme.bodySmall,
                  ),

                  const Spacer(),

                  // Collapse icon
                  Icon(
                    _collapsed
                        ? Icons.expand_more_rounded
                        : Icons.expand_less_rounded,
                    size: 16,
                    color: AppTheme.textSecondary,
                  ),
                ],
              ),
            ),
          ),

          // ── Body + children (collapsible) ───────────────────────────────
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: _collapsed
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // HTML comment body
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Html(
                          data: comment.text,
                          style: {
                            'body': Style(
                              fontSize: FontSize(13),
                              fontFamily: 'Verdana',
                              color: AppTheme.textPrimary,
                              lineHeight: LineHeight(1.5),
                              margin: Margins.zero,
                              padding: HtmlPaddings.zero,
                            ),
                            'a': Style(
                              color: AppTheme.hnOrange,
                              textDecoration: TextDecoration.none,
                            ),
                            'p': Style(
                              margin: Margins.only(bottom: 8),
                            ),
                            'pre': Style(
                              backgroundColor: AppTheme.surfaceVariant,
                              padding: HtmlPaddings.all(8),
                            ),
                            'code': Style(
                              fontFamily: 'monospace',
                              fontSize: FontSize(12),
                              backgroundColor: AppTheme.surfaceVariant,
                            ),
                          },
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Recursive children
                      if (comment.children.isNotEmpty)
                        Column(
                          children: comment.children
                              .map((child) =>
                                  CommentTile(key: ValueKey(child.id), comment: child))
                              .toList(),
                        ),

                      // Separator between sibling comments at depth 0
                      if (comment.depth == 0)
                        const Divider(height: 1, thickness: 1),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
