import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';

 import '../../data/models/notification_model.dart';
import 'notification_item.dart';

class NotificationLoading extends StatefulWidget {
  const NotificationLoading({super.key});

  @override
  State<NotificationLoading> createState() => _NotificationLoadingState();
}

class _NotificationLoadingState extends State<NotificationLoading> {
  @override
  Widget build(BuildContext context) {
    return   Expanded(
        child: ListView.separated(
      itemCount: 4,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return notificationLoading();
      },
    ));
  }  Widget notificationLoading() {
    return Skeletonizer(
      child: NotificationItem(
        notificationModel: NotificationModel(
          createdAt: DateTime.now(),
          title: 'Water Supply Interruption',
          message: " Water Supply Interruption Water Supply Interruption ",
        ),
      ),
    );
  }

}
