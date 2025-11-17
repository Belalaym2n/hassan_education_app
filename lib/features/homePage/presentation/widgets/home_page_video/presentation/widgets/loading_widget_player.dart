import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_colors.dart';


class LoadingVideoPlaceholder extends StatefulWidget {
  const LoadingVideoPlaceholder({super.key});

  @override
  State<LoadingVideoPlaceholder> createState() => _LoadingVideoPlaceholderState();
}

class _LoadingVideoPlaceholderState extends State<LoadingVideoPlaceholder>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late AnimationController _ringController;
  late AnimationController _textController;

  @override
  void initState() {
    super.initState();

    // Play icon pulse
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // Circular ring spin
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Fade animation for text
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _iconController.dispose();
    _ringController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Video Placeholder Container
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Gradient video frame placeholder


                // Animated spinning ring
                RotationTransition(
                  turns: _ringController,
                  child: CustomPaint(
                    size: const Size(90, 90),
                    painter: RingPainter(),
                  ),
                ),

                // Pulsing play icon
                ScaleTransition(
                  scale: Tween(begin: 0.9, end: 1.05).animate(
                    CurvedAnimation(parent: _iconController, curve: Curves.easeInOut),
                  ),
                  child: Icon(
                    Icons.play_circle_fill_rounded,
                    size: 64,
                    color: AppColors.primaryColor.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Loading text with fade effect
          FadeTransition(
            opacity: _textController,
            child: const Text(
              "جارٍ تحضير الفيديو...",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for creative ring loader
class RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          AppColors.primaryColor,
          AppColors.lightBlack.withOpacity(0.2),
          Colors.transparent
        ],
        startAngle: 0.0,
        endAngle: 3.14 * 2,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      3.14 * 1.5,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
