import 'package:amr_rezk_education/core/sharedWidgets/top_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../widgets/monthContent/month_content_item.dart';
import '../widgets/monthContent/promo_code.dart';

class MonthContentScreen extends StatefulWidget {
  const MonthContentScreen({super.key});

  @override
  State<MonthContentScreen> createState() => _MonthContentScreenState();
}

class _MonthContentScreenState extends State<MonthContentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TopScreenWidget(text: "محتوى الشهر"),
            SizedBox(height: AppConstants.h*0.04,),

            _buildHeadline(),

            ContentScreen(),
            PromoCode(),
            SizedBox(height: AppConstants.h * 0.02 ),
          ],
        ),
      ),
    );
  }

  _buildHeadline() {
    return Padding(
      padding: const EdgeInsets.only(
          right: 12.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          textAlign: TextAlign.right,
          "محاضرات شهر نوفمبر 📘",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppConstants.w * 0.05,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
