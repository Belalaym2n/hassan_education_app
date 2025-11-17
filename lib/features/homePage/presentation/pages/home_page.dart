
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../widgets/drawer/mobile_tablet_with_drawer.dart';
import '../widgets/home_item.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

    return MobileTabletScreen(

      h: AppConstants.h,
      w: AppConstants.w,
      zoomDrawerController: zoomDrawerController,
      mainScreen:HomeItem(
        zoomDrawerController: zoomDrawerController,
      ) ,
      isMobile: true,
    )   ;
  }
}
