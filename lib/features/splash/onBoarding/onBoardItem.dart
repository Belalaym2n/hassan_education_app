import 'dart:math';
import 'package:amr_rezk_education/config/routes/app_router.dart';
import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/features/signUp/presentation/pages/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'onBoardButtons.dart';
import 'onBoardModel.dart';

class OnBoardItem extends StatefulWidget {
  const OnBoardItem({super.key});

  @override
  State<OnBoardItem> createState() => _OnBoardItemState();
}

class _OnBoardItemState extends State<OnBoardItem>
    with SingleTickerProviderStateMixin {
  final PageController pageController = PageController();
  int currentIndex = 0;
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onBoardList.length,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final model = onBoardList[index];
                  final isActive = currentIndex == index;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.w * 0.08,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildImage(model.imagePath)
                            .animate()
                            .fadeIn(duration: 700.ms, curve: Curves.easeOut)
                            .moveY(
                              begin: 60,
                              end: 0,
                              curve: Curves.easeOutBack,
                            ),

                        SizedBox(height: AppConstants.h * 0.04),

                        Text(
                              model.headline,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: AppColors.primaryColor,
                                fontSize: AppConstants.w * 0.065,
                              ),
                            )
                            .animate(target: isActive ? 1 : 0)
                            .fade(duration: 500.ms)
                            .moveY(
                              begin: 20,
                              end: 0,
                              curve: Curves.easeOutBack,
                            ),

                        SizedBox(height: AppConstants.h * 0.02),

                        Text(
                              model.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: AppConstants.w * 0.04,
                                color: Colors.grey[700],
                                height: 1.6,
                              ),
                            )
                            .animate(target: isActive ? 1 : 0)
                            .fade(duration: 600.ms)
                            .moveY(
                              begin: 25,
                              end: 0,
                              curve: Curves.easeOutCubic,
                            ),

                        SizedBox(height: AppConstants.h * 0.04),

                        SmoothPageIndicator(
                              controller: pageController,
                              count: onBoardList.length,
                              effect: ExpandingDotsEffect(
                                spacing: 6.0,
                                radius: 10.0,
                                dotWidth: 10.0,
                                dotHeight: 10.0,
                                expansionFactor: 3,
                                dotColor: Colors.grey[300]!,
                                activeDotColor: AppColors.primaryColor,
                              ),
                              onDotClicked: (newIndex) {
                                pageController.animateToPage(
                                  newIndex,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                            )
                            .animate(target: isActive ? 1 : 0)
                            .fade(duration: 700.ms)
                            .moveY(
                              begin: 15,
                              end: 0,
                              curve: Curves.easeOutBack,
                            ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // أزرار التنقل بتأثير أنيق
            OnBoardButtons(
                  isLoading: isLoading,

                  onNext: () async {
                    if (currentIndex == onBoardList.length - 1) {
                      isLoading = true;

                      setState(() {});
                      await Future.delayed(Duration(milliseconds: 1500));
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.signUp, // اسم الـ route
                            (route) => false, // عشان يمسح كل الشاشات اللي قبلها
                      );

                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeOutCubic,
                      );
                    }
                  },
                  onBack: () {
                    if (currentIndex == 0) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeOutCubic,
                      );
                    } else {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeOutCubic,
                      );
                    }
                  },
                  isLastPage: currentIndex == onBoardList.length - 1,
                )
                .animate()
                .fadeIn(duration: 800.ms)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack),

            SizedBox(height: AppConstants.h * 0.02),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String imagePath) {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        final angle = sin(_floatController.value * 2 * pi) * 0.015;
        final offsetY = sin(_floatController.value * 2 * pi) * 10;
        return Transform.translate(
          offset: Offset(0, offsetY),
          child: Transform.rotate(angle: angle, child: child),
        );
      },
      child: Hero(
        tag: imagePath,
        child:
            Image.asset(
                  imagePath,
                  height: AppConstants.h * 0.4,
                  width: AppConstants.w / 1.2,
                  fit: BoxFit.cover,
                )
                .animate()
                .fadeIn(duration: 800.ms)
                .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
      ),
    );
  }
}
