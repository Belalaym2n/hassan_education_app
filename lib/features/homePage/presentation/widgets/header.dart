import 'package:amr_rezk_education/config/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';

///------------------------------
///   Mobile Header Widget
///------------------------------
class MobileHeader extends StatefulWidget {
  final double width;
  final double height;
  final bool isMobile;
  final ZoomDrawerController zoomDrawerController;

  const MobileHeader({
    super.key,
    required this.width,
    required this.height,
    required this.zoomDrawerController,
    this.isMobile = false,
  });

  @override
  State<MobileHeader> createState() => _MobileHeaderState();
}

class _MobileHeaderState extends State<MobileHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fadeMenuIcon;
  late Animation<Offset> _slideMenuIcon;

  late Animation<double> _fadeNotification;
  late Animation<Offset> _slideNotification;

  late Animation<double> _fadeWelcome;
  late Animation<Offset> _slideWelcome;

  @override
  void initState() {
    super.initState();

    // إعداد الأنيميشن
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // أيقونة القائمة
    _fadeMenuIcon = _createFadeAnimation(0.0, 0.4);
    _slideMenuIcon = _createSlideAnimation(const Offset(-0.2, 0), 0.0, 0.4);

    // أيقونة الإشعارات
    _fadeNotification = _createFadeAnimation(0.2, 0.6);
    _slideNotification = _createSlideAnimation(const Offset(0.2, 0), 0.2, 0.6);

    // نص الترحيب
    _fadeWelcome = _createFadeAnimation(0.5, 1.0);
    _slideWelcome = _createSlideAnimation(const Offset(0, 0.3), 0.5, 1.0);

    Future.delayed(const Duration(milliseconds: 150), () {
      _controller.forward();
    });
  }

  // إنشاء أنيميشن Fade
  Animation<double> _createFadeAnimation(double start, double end) {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );
  }

  // إنشاء أنيميشن Slide
  Animation<Offset> _createSlideAnimation(
    Offset begin,
    double start,
    double end,
  ) {
    return Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //==============================================================
  // Build UI
  //==============================================================
  @override
  Widget build(BuildContext context) {
    final double width = widget.width;
    final double height = widget.height;

    return AnimatedContainer(
      height: height * 0.1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.02,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Drawer Button Animation
          SlideTransition(
            position: _slideMenuIcon,
            child: FadeTransition(
              opacity: _fadeMenuIcon,
              child: _buildDrawerButton(context),
            ),
          ),

          SizedBox(width: AppConstants.w * 0.02),

          // Notification Animation
          SlideTransition(
            position: _slideNotification,
            child: FadeTransition(
              opacity: _fadeNotification,
              child: _buildNotificationIcon(),
            ),
          ),

          const Spacer(),

          // Welcome Animation
          SlideTransition(
            position: _slideWelcome,
            child: FadeTransition(
              opacity: _fadeWelcome,
              child: _buildWelcomeText(),
            ),
          ),

          if (widget.isMobile) SizedBox(width: width * 0.02),
        ],
      ),
    );
  }

  //==============================================================
  // Components
  //==============================================================

  Widget _buildDrawerButton(BuildContext context) {
    final iconSize = widget.isMobile
        ? widget.width * 0.08
        : widget.width * 0.03;

    return InkWell(
      onTap: () => ZoomDrawer.of(context)?.toggle(),
      borderRadius: BorderRadius.circular(12),
      child: _iconContainer(
        color: Colors.white,
        borderColor: Colors.grey.shade300,
        child: Icon(
          Icons.list_sharp,
          color: AppColors.primaryColor,
          size: iconSize,
        ),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return _iconContainer(
      color: Colors.transparent,
      borderColor: Colors.grey.shade300,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.notification);
        },
        child: Icon(
          Icons.notifications,
          color: Colors.white,
          size: AppConstants.w * 0.05,
        ),
      ),
    );
  }

  Widget _iconContainer({
    required Widget child,
    required Color color,
    required Color borderColor,
  }) {
    return Container(
      width: AppConstants.w * 0.13,
      height: AppConstants.w * 0.15,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }

  Widget _buildWelcomeText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Row(
              children: [
                SizedBox(width: 40),
                Text(
                  'مرحبًا',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFB2D9DB),
                    height: 1.4,
                  ),
                ),
              ],
            ),
            Text(
              'أيها الطالب',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(width: 14),
        _waveHandIcon(),
      ],
    );
  }

  Widget _waveHandIcon() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.2),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.orangeAccent.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: const Icon(
        Icons.waving_hand_rounded,
        color: Colors.orangeAccent,
        size: 20,
      ),
    );
  }
}
