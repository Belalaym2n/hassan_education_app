import 'package:amr_rezk_education/features/homePage/presentation/pages/home_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/utils/app_colors.dart';
import '../homePage/presentation/widgets/underDev.dart';
import '../lectures/presentation/pages/tabs_selcected_screen.dart';
import '../lectures/presentation/widgets/courses/courses_screen_item.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OneSignal.Notifications.requestPermission(true);
  }

  int currentIndex = 0;
  List<Widget> pages = [
    HomePageScreen(),

    FemaComingSoonPage(),
    FemaComingSoonPage(),
    FemaComingSoonPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          backgroundColor: Colors.transparent,
          color: AppColors.primaryColor,

          animationDuration: const Duration(milliseconds: 500),

          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
            // viewModel.updateIndex(index);
          },
          items: [
            Icon(
              Icons.home_outlined,
              color: currentIndex == 0
                  ? AppColors.secondaryColor
                  : Colors.white,
            ),

            Icon(
              FontAwesomeIcons.chalkboardTeacher,
              color: currentIndex == 1
                  ? AppColors.secondaryColor
                  : Colors.white,
            ),
            Icon(
              FontAwesomeIcons.percent,
              color: currentIndex == 2
                  ? AppColors.secondaryColor
                  : Colors.white,
            ),
            Icon(
              Icons.notifications_active,
              color: currentIndex == 3
                  ? AppColors.secondaryColor
                  : Colors.white,
            ),
          ],
        ),
        body: pages[currentIndex],
      ),
    );
  }
}
