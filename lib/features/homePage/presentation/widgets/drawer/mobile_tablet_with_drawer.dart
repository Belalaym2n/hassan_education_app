import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../../core/utils/app_colors.dart';
import 'buildMenus.dart';

class MobileTabletScreen extends StatefulWidget {
  MobileTabletScreen({
    super.key,
    required this.mainScreen,
    required this.zoomDrawerController,
    this.isMobile = true,
    required this.w,
    required this.h,
  });

  final double w;
  final double h;
  final ZoomDrawerController zoomDrawerController;
  bool isMobile;
  final Widget mainScreen;

  @override
  State<MobileTabletScreen> createState() => _MobileTabletScreenState();
}

class _MobileTabletScreenState extends State<MobileTabletScreen> {
  bool isTablet(double width) => width >= 600 && width < 1024;

  bool isMobile(double width) => width < 600;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ZoomDrawer(

      controller: widget.zoomDrawerController,
      menuBackgroundColor: isDark ? colorScheme.surface : Colors.white,
      shadowLayer1Color: isDark
          ? colorScheme.surfaceVariant
          : const Color(0xFFF5F5F5),
      shadowLayer2Color: isDark
          ? colorScheme.surfaceVariant.withOpacity(0.7)
          : const Color(0xFFE6E6E6).withOpacity(0.3),
      borderRadius: 32.0,
      showShadow: true,
      style: DrawerStyle.defaultStyle,
      angle: -12.0,
      drawerShadowsBackgroundColor: isDark
          ? Colors.black38
          : Colors.grey.shade300,
      slideWidth: MediaQuery.of(context).size.width * 0.7,
      menuScreen: BuildMenuScreen(isMobile: widget.isMobile),
      mainScreen: widget.mainScreen,
    );
  }
}
