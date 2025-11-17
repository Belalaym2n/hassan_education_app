import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart' show AppColors;
import '../utils/app_constants.dart' show AppConstants;

Widget large_button({
  required VoidCallback? onPressed, // ✅ كده يقبل null
  required String buttonName,
  bool isDisable=false,
  bool isDesktop=false
}) =>
    Align(
      alignment: Alignment.center,
      child:

ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: AppColors.primaryColor,
minimumSize: Size(AppConstants.w * 0.8, 50),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(14),
),),


        onPressed: isDisable ? null : onPressed, // ✅ مش لازم تعمل async call هنا

        child:  Center(
          child: Text(
            buttonName,
            style: TextStyle(
              color: Colors.white,
              fontSize:!isDesktop? AppConstants.w / 18:
              AppConstants.w / 65
              ,
              fontFamily: 'Nexa Bold 650',
            ),
          ),
        ),
      ),
    );