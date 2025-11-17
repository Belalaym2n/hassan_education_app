import 'package:flutter/material.dart';
import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/core/utils/app_images.dart';

class AmrIntro extends StatefulWidget {
  const AmrIntro({super.key});

  @override
  State<AmrIntro> createState() => _AmrIntroState();
}

class _AmrIntroState extends State<AmrIntro>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeImage;
  late Animation<Offset> _slideImage;
  late Animation<double> _fadeText;
  late Animation<Offset> _slideText;
  late Animation<double> _fadeButton;
  late Animation<Offset> _slideButton;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    // Animations
    _fadeImage = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4)),
    );
    _slideImage = Tween<Offset>(
      begin: const Offset(-0.2, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );

    _fadeText = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.7)),
    );
    _slideText = Tween<Offset>(
      begin: const Offset(0.2, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );

    _fadeButton = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1.0)),
    );
    _slideButton = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1.0, curve: Curves.easeOut)),
    );

    // Start animation once the screen builds
    Future.delayed(const Duration(milliseconds: 150), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.w,
      height: AppConstants.h * 0.22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppConstants.w * 0.04),
          bottomRight: Radius.circular(AppConstants.w * 0.04),
        ),
        color: AppColors.primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.08),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصورة مع أنيميشن ناعمة
            SlideTransition(
              position: _slideImage,
              child: FadeTransition(
                opacity: _fadeImage,
                child: _image(),
              ),
            ),

            const SizedBox(width: 18),

            // النصوص (العنوان + الوصف + الزر)
            Expanded(
              child: SlideTransition(
                position: _slideText,
                child: FadeTransition(
                  opacity: _fadeText,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _headlineText(),
                      const SizedBox(height: 10),
                      _description(),
                      const SizedBox(height: 10),

                      // زر مع أنيميشن مستقلة
                      SlideTransition(
                        position: _slideButton,
                        child: FadeTransition(
                          opacity: _fadeButton,
                          child: bookNow(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headlineText() {
    return const Text(
      "مرحبًا بك في منصة\nالأستاذ ناجي للإنجليزية",
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w900,
        height: 1.3,
        letterSpacing: 0.6,
        color: Colors.white,
      ),
    );
  }

  Widget _description() {
    return SizedBox(
      width: AppConstants.w * 0.4,
      child: const Text(
        'ابدأ رحلتك لتفهم  بوضوحٍ تام.'
            'دروسٌ سهلةٌ تبني فيك  حبَّ \nالفهم '
            'مع الأستاذِ ناجي تتفتحُ الهمم.',
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 10,
          height: 1.6,
          color: Color(0xFFEEEEEE),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget bookNow() {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.w * 0.04),
          ),
        ),
      ),
      onPressed: () {},
      label: Text(
        "احجز الآن",
        style: TextStyle(
          fontSize: 14,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _image() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 3),
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          "assets/images/hand-holding-smartphone-with-tutor-screen.png",
          width: AppConstants.w * 0.41,
          height: AppConstants.w * 0.42,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
