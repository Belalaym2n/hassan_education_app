import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';

Widget teacherName() {
  return Container(width: AppConstants.w,
 decoration: BoxDecoration(
   color:       AppColors.primaryColor ,

 ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: AppConstants.w * 0.9,
        padding: EdgeInsets.symmetric(
          vertical: AppConstants.h * 0.004,
          horizontal: AppConstants.w * 0.05,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
              AppConstants.w * 0.04),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _build_teacher_icon(),

                SizedBox(width: AppConstants.w * 0.04),

                // النصوص
                _build_teacher_name()
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
Widget _build_teacher_name() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: Text(
          'منصة أستاذ حسن التعليمية',
          style: TextStyle(
            color: const Color(0xFF333333),
            fontSize: AppConstants.w * 0.044, // 16 / 360
            fontWeight: FontWeight.w900,
            letterSpacing: AppConstants.w * 0.00083, // 0.3 / 360
          ),
        ),
      ),

      SizedBox(height: AppConstants.h * 0.00),

      Text(
        'Mr. Hassan Educational Platform',
        style: TextStyle(
          color: const Color(0xFF757575),
          fontSize: AppConstants.w * 0.0333, // 12 / 360
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

Widget _build_teacher_icon(){
  return         Container(
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
  );
}
