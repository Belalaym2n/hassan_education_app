import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../core/utils/app_colors.dart';

class WhyChooseAmr extends StatefulWidget {
    WhyChooseAmr({super.key,required this.name});
String name;
  @override
  State<WhyChooseAmr> createState() => _WhyChooseAmrState();
}

class _WhyChooseAmrState extends State<WhyChooseAmr>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeTitle;
  late Animation<double> _scaleTitle;
  late Animation<double> _lineWidth;
  late Animation<double> _fadeDesc;
  late Animation<Offset> _slideDesc;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _fadeTitle = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    );

    _scaleTitle = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOutBack),
      ),
    );

    _lineWidth = Tween<double>(begin: 0, end: 120).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.55, curve: Curves.easeInOut),
      ),
    );

    _fadeDesc = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    );

    _slideDesc = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24,
          vertical: 4.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            seeAllButton(),
            FadeTransition(
              opacity: _fadeTitle,
              child: ScaleTransition(
                scale: _scaleTitle,
                child: whyChoose(),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget whyChoose() {
    return Text(
     widget.name,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
        height: 1.3,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget seeAllButton() {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 16,
        color: Color(0xFF757575),
      ),
      label: const Text(
        "عرض الكل",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF757575),
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        foregroundColor: AppColors.primaryColor,
      ),
    );
  }
}
