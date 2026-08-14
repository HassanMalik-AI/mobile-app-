import 'package:flutter/material.dart';

/// Circular progress ring drawn with a [CustomPainter]. Animates its fill
/// from 0 to [progress] whenever the widget first appears or [progress]
/// changes, with an accent-colored stroke and a number in the center.
class ProgressRingWidget extends StatefulWidget {
  const ProgressRingWidget({
    super.key,
    required this.progress,
    this.centerText,
    this.size = 120,
    this.strokeWidth = 10,
    this.color,
    this.trackColor,
    this.duration = const Duration(milliseconds: 900),
  }) : assert(progress >= 0 && progress <= 1, 'progress must be in [0, 1]');

  /// Value between 0.0 and 1.0.
  final double progress;

  /// Text shown in the center of the ring, e.g. "72%" or "12".
  final String? centerText;

  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? trackColor;
  final Duration duration;

  @override
  State<ProgressRingWidget> createState() => _ProgressRingWidgetState();
}

class _ProgressRingWidgetState extends State<ProgressRingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(
      begin: 0,
      end: widget.progress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant ProgressRingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(begin: _animation.value, end: widget.progress)
          .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
          );
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ringColor = widget.color ?? theme.colorScheme.primary;
    final track = widget.trackColor ?? theme.dividerColor;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          return CustomPaint(
            painter: _ProgressRingPainter(
              progress: _animation.value,
              color: ringColor,
              trackColor: track,
              strokeWidth: widget.strokeWidth,
            ),
            child: Center(
              child: widget.centerText == null
                  ? null
                  : Text(
                      widget.centerText!,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  _ProgressRingPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Background track (full circle).
    canvas.drawCircle(center, radius, trackPaint);

    // Foreground arc, starting at the top (-90deg) going clockwise.
    const startAngle = -3.14159265 / 2;
    final sweepAngle = 2 * 3.14159265 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
