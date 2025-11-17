 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

  import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../data/models/notification_model.dart';

class NotificationDetailed extends StatefulWidget {
  final NotificationModel notificationModel;

  NotificationDetailed({super.key, required this.notificationModel});

  @override
  State<NotificationDetailed> createState() => _NotificationDetailedState();
}

class _NotificationDetailedState extends State<NotificationDetailed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(  "Notification Details"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
            size: AppConstants.w* 0.07,
            color:
            AppColors.primaryColor), // Set the app bar icon color to match theme
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.w * 0.04),
        // Add padding to body for spacing
        child: ListView(
          children: [


            SizedBox(height: AppConstants.h * 0.03),
            _buildHeadline(),
            SizedBox(height: AppConstants.h * 0.02),
            _buildDescription(),
            SizedBox(height:AppConstants.h* 0.07),
          ],
        ),
      ),
    );
  }


   Widget _buildHeadline() {
    return Text(
      widget.notificationModel.title,
      style: TextStyle(
        fontSize: AppConstants.w* 0.055,
        // Slightly larger font size for headline
        fontWeight: FontWeight.w600,
        color: AppColors.primaryColor, // Use primary color for consistency
      ),
      textAlign: TextAlign.start, // Center align the headline
    );
  }

  // Function to build the description
  Widget _buildDescription() {
    return Text(
      widget.notificationModel.message ?? 'No description available.',
      style: TextStyle(
        fontSize:AppConstants.w * 0.035,
        // Consistent font size for description
        fontWeight: FontWeight.w400,
        color: AppColors.lightBlack, // Use a softer color for the description
      ),
    );
  }
}
