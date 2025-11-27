import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
 import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../whyChooseTeacher/whyChooseAmr.dart';
import 'featureItem.dart';
import 'featuresModel.dart';

class AmrFeatures extends StatefulWidget {
  const AmrFeatures({super.key});

  @override
  State<AmrFeatures> createState() => _AmrFeaturesState();
}

class _AmrFeaturesState extends State<AmrFeatures>
    with SingleTickerProviderStateMixin {
  bool _visible = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // إعداد الأنيميشن
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // تأخير 1.5 ثانية قبل إظهار الشاشة
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => _visible = true);
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //===========================================================
  // BUILD
  //===========================================================
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      child: _visible
          ? FadeTransition(
        opacity: _fadeAnimation,
        child: _amrFeatures(),
      )
          : const SizedBox(
        height: 320, // نفس ارتفاع المحتوى علشان ما يحصلش Jump
        child: SizedBox.expand(), // يملأ المساحة الفاضية
      ),
    );
  }

  Widget _amrFeatures() {
    return Column(
      children: [
        WhyChooseTeacher(name: "ليه تختارنا؟"),
        SizedBox(
          height: AppConstants.h * 0.01316, // 10 / 760
        ),
        SizedBox(
          height: AppConstants.h * 0.3421, // 260 / 760
          child: ListView.builder(

            scrollDirection: Axis.horizontal,
            itemCount: featuresList.length,
            itemBuilder: (context, index) {
              final feature = featuresList[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.w * 0.0222, // 8 / 360
                ),
                child: FeatureItem(feature: feature, index: index),
              );
            },
          ),
        ),
      ],
    );
  }
}
