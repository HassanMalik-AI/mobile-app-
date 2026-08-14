import 'package:flutter/material.dart';

/// Full-width pill button, outlined, with a border in the theme's
/// text-secondary color. Use for secondary actions alongside a
/// [PrimaryButton], e.g. "Skip" or "View Details".
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.height = 56,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textSecondary =
        theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurface;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: theme.textTheme.bodyLarge?.color,
          side: BorderSide(color: textSecondary, width: 1),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: textSecondary),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
