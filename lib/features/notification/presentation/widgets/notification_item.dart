import 'package:flutter/material.dart';
  import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../data/models/notification_model.dart';
import 'notificationDetails.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationItem({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(AppConstants.w * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppConstants.w * 0.07,
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            child: Icon(Icons.notifications, color: AppColors.primaryColor),
          ),
          SizedBox(width: AppConstants.w * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notificationModel.title,
                        style: TextStyle(
                          fontSize: AppConstants.w * 0.042,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      notificationModel.createdAt.toString().substring(10,16),
                      style: TextStyle(
                        fontSize: AppConstants.w * 0.034,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppConstants.h * 0.006),
                Text(
                  notificationModel.message ?? '',
                  style: TextStyle(
                    fontSize: AppConstants.w * 0.035,
                    color: AppColors.lightBlack,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppConstants.h * 0.012),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      notificationModel.createdAt.toString().substring(0,10),
                      style: TextStyle(fontSize: AppConstants.w * 0.033, color: Colors.grey.shade600),
                    ),
                    const Spacer(),
                    TextButton(

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NotificationDetailed(notificationModel: notificationModel),
                          ),
                        );
                      },
                      child: const Text(
                        "View Details",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
