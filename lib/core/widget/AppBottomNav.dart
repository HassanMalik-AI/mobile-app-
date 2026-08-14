import 'package:flutter/material.dart';

/// Five-item bottom navigation bar: Home, Workout, Progress, AI Coach,
/// Profile. The active tab shows the filled icon variant in the primary
/// accent color; inactive tabs show the outlined variant in the
/// secondary text color.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    _NavItemData(
      label: 'Home',
      outlined: Icons.home_outlined,
      filled: Icons.home,
    ),
    _NavItemData(
      label: 'Workout',
      outlined: Icons.fitness_center_outlined,
      filled: Icons.fitness_center,
    ),
    _NavItemData(
      label: 'Progress',
      outlined: Icons.insights_outlined,
      filled: Icons.insights,
    ),
    _NavItemData(
      label: 'AI Coach',
      outlined: Icons.auto_awesome_outlined,
      filled: Icons.auto_awesome,
    ),
    _NavItemData(
      label: 'Profile',
      outlined: Icons.person_outline,
      filled: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = theme.colorScheme.primary;
    final inactiveColor =
        theme.textTheme.bodySmall?.color ?? theme.colorScheme.onSurface;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: theme.dividerColor, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isActive = index == currentIndex;
              final color = isActive ? activeColor : inactiveColor;

              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isActive ? item.filled : item.outlined,
                        color: color,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: color,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.label,
    required this.outlined,
    required this.filled,
  });

  final String label;
  final IconData outlined;
  final IconData filled;
}
