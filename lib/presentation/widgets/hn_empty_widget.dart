import 'package:flutter/material.dart';
import 'package:hn_reader/core/theme/app_theme.dart';

/// Full-screen empty-state widget.
///
/// Shown when a feed or comment section has no items to display.
class HnEmptyWidget extends StatelessWidget {
  const HnEmptyWidget({
    super.key,
    this.message = 'Nothing to see here.',
    this.icon = Icons.inbox_outlined,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 48,
            color: AppTheme.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
