import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/features/homePage/presentation/widgets/educationStages/stages_model.dart';

class AnimatedStageCard extends StatefulWidget {
  final StagesModel stage;
  final int index;
  final VoidCallback? onTap;

  const AnimatedStageCard({
    super.key,
    required this.stage,
    required this.index,
    this.onTap,
  });

  @override
  State<AnimatedStageCard> createState() => _AnimatedStageCardState();
}

class _AnimatedStageCardState extends State<AnimatedStageCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeImage;
  late final Animation<Offset> _slideImage;
  late final Animation<double> _fadeText;
  late final Animation<Offset> _slideText;

  bool _visible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Image animation (enter first)
    _fadeImage = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _slideImage = Tween<Offset>(
      begin: const Offset(0.2, 0), // من اليمين بخفة
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
    ));

    // Text animation (after image)
    _fadeText = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );

    _slideText = Tween<Offset>(
      begin: const Offset(0, 0.25), // من الأسفل بخفة
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOutBack),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.4 && !_visible) {
      setState(() => _visible = true);
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('stage-${widget.index}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: AppConstants.w * 0.6,
            height: AppConstants.h * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeTransition(
                  opacity: _fadeImage,
                  child: SlideTransition(
                    position: _slideImage,
                    child: _StageImage(imagePath: widget.stage.imagePath),
                  ),
                ),
                const SizedBox(height: 12),
                FadeTransition(
                  opacity: _fadeText,
                  child: SlideTransition(
                    position: _slideText,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _StageHeader(
                            title: widget.stage.title,
                            icon: widget.stage.icon,
                          ),
                          const SizedBox(height: 8),
                          _StageDescription(text: widget.stage.description),
                          const SizedBox(height: 10),
                          const _StartNowButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --------------------- SUB-WIDGETS ---------------------

class _StageImage extends StatelessWidget {
  final String imagePath;

  const _StageImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Image.asset(
        imagePath,
        width: AppConstants.w * 0.6,
        height: AppConstants.w * 0.4,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _StageHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _StageHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 22),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              height: 1.2,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _StageDescription extends StatelessWidget {
  final String text;

  const _StageDescription({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        color: Color(0xFF555555),
        height: 1.6,
      ),
    );
  }
}

class _StartNowButton extends StatelessWidget {
  const _StartNowButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          elevation: 0,
        ),
        onPressed: () {},
        icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        label: const Text(
          "ابدأ الآن",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
