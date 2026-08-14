import 'package:flutter/material.dart';

/// A shimmering placeholder card that matches [StatCard]'s shape and
/// padding, for use while stat data is loading.
class LoadingSkeletonCard extends StatefulWidget {
  const LoadingSkeletonCard({
    super.key,
    this.padding = const EdgeInsets.all(20),
  });

  final EdgeInsets padding;

  @override
  State<LoadingSkeletonCard> createState() => _LoadingSkeletonCardState();
}

class _LoadingSkeletonCardState extends State<LoadingSkeletonCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardShape = theme.cardTheme.shape as RoundedRectangleBorder?;
    final baseColor = theme.cardTheme.color ?? theme.colorScheme.surface;
    final highlightColor = theme.dividerColor;

    return Card(
      margin: EdgeInsets.zero,
      color: baseColor,
      elevation: theme.cardTheme.elevation ?? 0,
      shadowColor: theme.cardTheme.shadowColor,
      shape: cardShape,
      child: Padding(
        padding: widget.padding,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (bounds) {
                final slide = _controller.value;
                return LinearGradient(
                  begin: Alignment(-1 - slide * 2, 0),
                  end: Alignment(1 - slide * 2, 0),
                  colors: [baseColor, highlightColor, baseColor],
                  stops: const [0.35, 0.5, 0.65],
                ).createShader(bounds);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _bar(width: 22, height: 22, color: baseColor, round: true),
                  const SizedBox(height: 10),
                  _bar(width: 90, height: 28, color: baseColor),
                  const SizedBox(height: 8),
                  _bar(width: 60, height: 14, color: baseColor),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _bar({
    required double width,
    required double height,
    required Color color,
    bool round = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        shape: round ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: round ? null : BorderRadius.circular(6),
      ),
    );
  }
}
