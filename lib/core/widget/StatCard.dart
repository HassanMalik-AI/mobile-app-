import 'package:flutter/material.dart';

/// A card that highlights a single stat: a big headline-style, accent
/// colored number with a small secondary-colored label underneath.
/// Use for things like calories burned, current streak, workouts done.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.value,
    required this.label,
    this.accentColor,
    this.icon,
    this.padding = const EdgeInsets.all(20),
  });

  final String value;
  final String label;
  final Color? accentColor;
  final IconData? icon;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = accentColor ?? theme.colorScheme.primary;
    final cardShape = theme.cardTheme.shape as RoundedRectangleBorder?;

    return Card(
      margin: EdgeInsets.zero,
      color: theme.cardTheme.color,
      elevation: theme.cardTheme.elevation ?? 0,
      shadowColor: theme.cardTheme.shadowColor,
      shape: cardShape,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: accent, size: 22),
              const SizedBox(height: 10),
            ],
            Text(
              value,
              style: theme.textTheme.headlineLarge?.copyWith(
                color: accent,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 6),
            Text(label, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
