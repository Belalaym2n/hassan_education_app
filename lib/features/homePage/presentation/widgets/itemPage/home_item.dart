import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/features/homePage/presentation/widgets/homeHeader/teacherName.dart';
import 'package:amr_rezk_education/features/homePage/presentation/widgets/whyChooseTeacher/whyChooseAmr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

 import '../educationStages/educational_stages.dart';
import '../homeHeader/header.dart';
import '../homeHeader/teacher_brief.dart';
import '../teacherFeatures/teacher_features.dart';

class HomeItem extends StatefulWidget {
    HomeItem({super.key,required this.zoomDrawerController});
  final ZoomDrawerController zoomDrawerController;

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(

      SystemUiOverlayStyle(
        systemNavigationBarDividerColor: AppColors.primaryColor,
        systemStatusBarContrastEnforced: true,

        systemNavigationBarColor: AppColors.primaryColor,
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light, // الأيقونات بالأسود
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(

      SystemUiOverlayStyle(
        systemNavigationBarDividerColor: AppColors.primaryColor,

        systemStatusBarContrastEnforced: true,
        systemNavigationBarColor: AppColors.primaryColor,
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light, // الأيقونات بالأسود
      ),
    );

    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.white,
        appBar:   AppBar(

toolbarHeight: 0,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,

    ),

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

                        TeacherBrief(),
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
      ),
    );
  }
}
