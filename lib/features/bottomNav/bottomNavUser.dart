
import 'package:amr_rezk_education/features/homePage/presentation/pages/home_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/utils/app_colors.dart';
import '../homePage/presentation/widgets/underDev.dart';
 import '../lectures/presentation/pages/coursesScreen.dart';
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
  int currentIndex=0;
  List<Widget>pages=[
    HomePageScreen(),

    CoursesScreen(),
    FemaComingSoonPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
                height: 50,
                backgroundColor: Colors.transparent,
                color: AppColors.primaryColor,
                animationDuration: const Duration(milliseconds: 500),
                onTap: (int index) {
                  setState(() {
                    currentIndex=index;
                  });
                  // viewModel.updateIndex(index);
                },
                items: const [
                  Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),

                  Icon(
                  FontAwesomeIcons.chalkboardTeacher,
                    color: Colors.white,
                  ),
                  Icon(
                    FontAwesomeIcons.percent,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                  ),
                ]),
            body:  pages[currentIndex]


      ),
    );
  }
}

