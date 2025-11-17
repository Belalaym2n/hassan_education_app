import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/features/homePage/presentation/widgets/teacherName.dart';
import 'package:amr_rezk_education/features/homePage/presentation/widgets/whyChooseAmr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'amrFeatures/amr_features.dart';
import 'educationStages/educational_stages.dart';
import 'header.dart';
import 'amr_intro.dart';
import 'home_page_video/presentation/pages/video_section.dart';

class HomeItem extends StatefulWidget {
    HomeItem({super.key,required this.zoomDrawerController});
  final ZoomDrawerController zoomDrawerController;

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light, // الأيقونات بالأسود
      ),
    );


    return Scaffold(
      body: Container(

        color: Colors.grey[50],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MobileHeader(
              zoomDrawerController: widget.zoomDrawerController,
              isMobile: true,
              height: AppConstants.h,
              width: AppConstants.w,
            ),

            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(
                  context,
                ).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      teacherName(),

                      AmrIntro(),
                      SizedBox(height: 15,),


                      AmrFeatures(),
                      SizedBox(height: 15,),

                      EducationalStages(),
                      SizedBox(height: 15,),

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
}
