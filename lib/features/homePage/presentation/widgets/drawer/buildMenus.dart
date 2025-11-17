import 'package:amr_rezk_education/features/homePage/presentation/widgets/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_images.dart';
import 'menuModel.dart';
import 'menu_item.dart';

class BuildMenuScreen extends StatefulWidget {
  BuildMenuScreen({super.key, this.isMobile = true});

  bool isMobile;

  @override
  State<BuildMenuScreen> createState() => _BuildMenuScreenState();
}

int _selectedIndex = -1;

class _BuildMenuScreenState extends State<BuildMenuScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final List<MenuModel> pages = MenuModel.getItems(context);
    amrText(double width, double height,

        {bool isMobile = false,bool isDrawer=false}) {
      return Text(
      "Amr",
        style:TextStyle(
            fontSize: !isMobile ? width * 0.02 : width * 0.06,
            fontWeight: FontWeight.bold,
            color:  isDrawer?AppColors.primaryColor:Colors.white,
            letterSpacing: 0.5,
            height: 1
        ),
      );
    }
    Widget userInfo() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(0.0444 * w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0.0444 * w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 0.0277 * w,
              offset: Offset(0, 0.00515 * h),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppConstants.w * 0.025),
              decoration: BoxDecoration(
                color: const Color(0xFFB2D9DB).withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.person_crop_square,
                size: AppConstants.w * 0.07,
                color: AppColors.primaryColor, // اللون الأساسي (برتقالي فاتح)
              ),
            ),

            SizedBox(width: 0.0144 * w),
            Center(child: amrText(w, h, isMobile: true, isDrawer: true)),
          ],
        ),
      );
    }



    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0.0103 * h,
          horizontal: 0.0222 * w,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userInfo(),
              SizedBox(height: 0.04123 * h),
              MenuItem(
                isMobile: widget.isMobile,
                title: pages[0].pageName,
                icon: Icons.home,
                // أيقونة مبنى شركة
                isSelected: _selectedIndex == 0,
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),

              MenuItem(
                isMobile: widget.isMobile,

                title: pages[1].pageName,
                icon: Icons.people,
                isSelected: _selectedIndex == 1,
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              MenuItem(
                isMobile: widget.isMobile,

                title: pages[2].pageName,
                icon: Icons.phone_android,
                // أيقونة مبنى شركة
                isSelected: _selectedIndex == 2,
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
              MenuItem(
                isMobile: widget.isMobile,

                title: pages[3].pageName,
                icon: FontAwesomeIcons.newspaper,
                isSelected: _selectedIndex == 3,
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
              ),
              MenuItem(
                isMobile: widget.isMobile,

                title: pages[4].pageName,
                icon: FontAwesomeIcons.message,
                isSelected: _selectedIndex == 4,
                onTap: () {
                  setState(() {
                    _selectedIndex = 4;
                  });
                },
              ),
              SizedBox(height: h * 0.1),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      _selectedIndex = 5;
                    });
                  },
                  child: const Text(
                    "تسجيل الخروج",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
