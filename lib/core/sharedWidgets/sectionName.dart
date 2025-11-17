import 'package:flutter/cupertino.dart';

import '../utils/app_colors.dart';

Widget sectionName(String name) {
  return Text(
    name,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryColor,
      height: 1.3,
      letterSpacing: 1.1,
    ),
  );
}

Widget buildLine({
  required double width
}){
  return    Container(
    width: width,
    height: 4,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.accentColor,
          AppColors.primaryColor,
          AppColors.secondaryColor,
        ],
      ),
      borderRadius: BorderRadius.circular(20),
    ),
  );
}