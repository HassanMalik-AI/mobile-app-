import 'package:flutter/material.dart';

/// Small pill badge showing a day count to an upcoming event, e.g.
/// "12 days to Marathon". Rendered in the theme's secondary accent
/// (coral ember / coral) color.
class CountdownBadge extends StatelessWidget {
  const CountdownBadge({
    super.key,
    required this.daysRemaining,
    required this.eventName,
    this.icon = Icons.event_outlined,
  });

  final int daysRemaining;
  final String eventName;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;

    final dayLabel = daysRemaining == 1 ? 'day' : 'days';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: accent),
            const SizedBox(width: 6),
          ],
          Text(
            '$daysRemaining $dayLabel to $eventName',
            style: theme.textTheme.labelMedium?.copyWith(
              color: accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
