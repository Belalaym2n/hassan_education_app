import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/sharedWidgets/top_screen_widget.dart';
import '../../data/models/notification_model.dart';
import 'notification_item.dart';

class ShowAllNotificationScreen extends StatefulWidget {
  const ShowAllNotificationScreen({super.key, required this.notifications});

  final List<NotificationModel> notifications;

  @override
  State<ShowAllNotificationScreen> createState() =>
      _ShowAllNotificationScreenState();
}

class _ShowAllNotificationScreenState extends State<ShowAllNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child:

          Expanded(
            child: ListView.separated(
              itemCount: widget.notifications.length,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final notification = widget.notifications[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  delay: Duration(milliseconds: 80 * index),
                  child: SlideAnimation(
                    verticalOffset: 60,
                    curve: Curves.easeOutExpo,
                    child: FadeInAnimation(
                      curve: Curves.easeIn,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: -0.08, end: 0),
                        // rotation tilt
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOutBack,
                        builder: (context, tilt, child) {
                          return Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001) // perspective
                              ..rotateZ(tilt),
                            alignment: Alignment.center,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 700),
                              curve: Curves.easeOutCubic,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 14,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: child,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: NotificationItem(
                            notificationModel: notification,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

    );
  }
}
