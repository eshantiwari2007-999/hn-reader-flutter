import 'package:flutter/material.dart';
import 'package:hn_reader/core/theme/app_theme.dart';

/// Full-screen error state widget.
///
/// Displays a friendly error message and a retry button.
/// The [onRetry] callback is invoked when the user taps "Try Again".
class HnErrorWidget extends StatelessWidget {
  const HnErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;

  /// Called when the user taps the retry button. Pass null to hide the button.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error icon
            Icon(
              Icons.wifi_off_rounded,
              size: 48,
              color: AppTheme.textSecondary.withOpacity(0.6),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              'Something went wrong',
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Detail message
            Text(
              message,
              style: textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            // Retry button
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Try Again'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.hnOrange,
                  side: const BorderSide(color: AppTheme.hnOrange),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
