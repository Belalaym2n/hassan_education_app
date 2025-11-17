import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';

class EmptyNotificationsWidget extends StatelessWidget {
  const EmptyNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppConstants.initSize(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.w * 0.08,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: AppConstants.h * 0.2),

              /// --- أيقونة الإشعارات ---
              Container(
                height: AppConstants.h*0.2,
                padding: EdgeInsets.all(AppConstants.w * 0.05),
                decoration: BoxDecoration(
                  color:                  AppColors.primaryColor
                      .withOpacity(0.12),                  shape: BoxShape.circle,

                ),
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: AppConstants.h * 0.08,
                  color:    AppColors.primaryColor,
                ),
              ),




              /// --- العنوان ---
              Text(
                "لا توجد إشعارات حالياً",
                style: TextStyle(
                  fontSize: AppConstants.h * 0.031,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppConstants.h * 0.015),

              /// --- الوصف ---
              Text(
                "في الوقت الحالي لا توجد رسائل جديدة.\nسنقوم بإعلامك فور وصول أي إشعار جديد.",
                style: TextStyle(
                  fontSize: AppConstants.h * 0.02,
                  color: Colors.grey.shade600,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppConstants.h * 0.04),

              /// -
            ],
          ),
        ),
      ),
    );
  }
}
