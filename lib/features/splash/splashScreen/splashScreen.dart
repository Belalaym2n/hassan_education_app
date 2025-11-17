import 'package:amr_rezk_education/features/login/presentation/pages/auto_login_screen.dart';
import 'package:amr_rezk_education/features/splash/onBoarding/onBoardScreens.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../config/routes/app_router.dart';
import '../../../core/utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _fadeOutController;
  bool _showWhiteScreen = false;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(vsync: this);
    _fadeOutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  Future<void> _startSequence() async {
    // 1️⃣ تشغيل اللوتي بالمدة الصحيحة
    await _logoController.forward();

    // 2️⃣ بدء الفيد آوت بعد انتهاء اللوتي
    await _fadeOutController.forward();

    // 3️⃣ شاشة بيضاء بسيطة بعد الاختفاء
    setState(() => _showWhiteScreen = true);
    await Future.delayed(const Duration(milliseconds: 500));

    // 4️⃣ الانتقال إلى شاشة OnBoarding
    if (mounted) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final fade =
          CurvedAnimation(parent: animation, curve: Curves.easeInOut);
          final scale = Tween<double>(begin: 0.95, end: 1.0).animate(fade);
          return FadeTransition(
            opacity: fade,
            child: ScaleTransition(scale: scale, child: child),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) =>
        const AutoLogin(),
      ));
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fadeOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double w = AppConstants.w;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _showWhiteScreen
            ? const SizedBox.shrink()
            : FadeTransition(
          opacity: Tween<double>(begin: 1, end: 0).animate(
            CurvedAnimation(
              parent: _fadeOutController,
              curve: Curves.easeOut,
            ),
          ),
          child: SizedBox(
            width: w * 0.8,
            child: Lottie.asset(
              'assets/json/educationLearn.json',
              controller: _logoController,
              onLoaded: (composition) async {
                 _logoController.duration = composition.duration;
                await _startSequence();
              },
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
