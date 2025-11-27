import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'featureItem.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'featuresModel.dart';

class FeatureItem extends StatefulWidget {
  final FeatureModel feature;
  final int index;

  const FeatureItem({super.key, required this.feature, required this.index});

  @override
  State<FeatureItem> createState() => _FeatureItemState();
}

class _FeatureItemState extends State<FeatureItem>
    with SingleTickerProviderStateMixin {
  bool _visible = false;
  late AnimationController _controller;
  late Animation<double> _fadeImage;
  late Animation<Offset> _slideImage;
  late Animation<double> _fadeText;
  late Animation<Offset> _slideText;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeImage = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _slideImage = Tween<Offset>(begin: const Offset(0.2, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
          ),
        );

    _fadeText = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );

    _slideText = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 1.0, curve: Curves.easeOutBack),
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.5 && !_visible) {
      setState(() => _visible = true);
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('feature-${widget.index}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.w * 0.05),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SizedBox(
          height: AppConstants.h * 0.12,

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeTransition(
                  opacity: _fadeImage,
                  child: SlideTransition(
                    position: _slideImage,
                    child: buildImage(widget.feature),
                  ),
                ),
                const SizedBox(height: 12),
                FadeTransition(
                  opacity: _fadeText,
                  child: SlideTransition(
                    position: _slideText,
                    child: buildTexts(widget.feature),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTexts(FeatureModel feature) {
    return SizedBox(
      width: AppConstants.w * 0.35,
      child: Column(
        children: [
          Text(
            feature.tittle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppConstants.w * 0.044, // 16 / 360
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              height: 1.3,
            ),
          ),

          SizedBox(height: AppConstants.h * 0.00789), // 6 / 760

          Text(
            feature.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppConstants.w * 0.0236, // 8.5 / 360
              color: Color(0xFF757575),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(FeatureModel feature) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: AppConstants.w * 0.28,
          height: AppConstants.w * 0.28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppConstants.w * 0.0555, // 20 / 360
            ),
          ),
        ),

        _buil_icon_image(   feature.imagePath),
_build_icon( feature.icon),

      ],
    );
  }

  Widget _build_icon(IconData icon){
    return  Icon(
  icon,
      color: AppColors.primaryColor,
      size: AppConstants.w * 0.116, // 42 / 360
    );
  }
  Widget _buil_icon_image(String imagePath ){
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        AppConstants.w * 0.05, // 18 / 360
      ),
      child: Image.asset(
       imagePath,
        fit: BoxFit.cover,
        width: AppConstants.w * 0.24,
        height: AppConstants.w * 0.24,
      ),
    );
  }

}
