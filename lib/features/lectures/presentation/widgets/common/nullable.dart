import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_constants.dart';

nullableWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.home_outlined,
          size: AppConstants.w * 0.25,
          color: Colors.grey.shade400,
        ),
        const SizedBox(height: 16),
        Text(
          "No apartments available",
          style: TextStyle(
            fontSize: AppConstants.w * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "Check back later or try refreshing the page.",
          style: TextStyle(
            fontSize: AppConstants.w * 0.04,
            color: Colors.grey.shade500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}