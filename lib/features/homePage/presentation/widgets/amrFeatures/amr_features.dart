import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/features/homePage/presentation/widgets/amrFeatures/featuresModel.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../whyChooseAmr.dart';
import 'featureItem.dart';

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

  //===========================================================
  // UI CONTENT
  //===========================================================
  Widget _amrFeatures() {
    return Column(
      children: [
          WhyChooseAmr(name: "ليه تختارنا؟"),
        const SizedBox(height: 10),
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuresList.length,
            itemBuilder: (context, index) {
              final feature = featuresList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FeatureItem(feature: feature, index: index),
              );
            },
          ),
        ),
      ],
    );
  }
}
