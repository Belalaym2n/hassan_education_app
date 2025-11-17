import 'package:amr_rezk_education/core/intialization/init_di.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/sharedWidgets/top_screen_widget.dart';
import '../../../../core/utils/app_constants.dart';
import '../../data/models/notification_model.dart';
import '../../domain/use_cases/user_notifications_use_case.dart';
import '../bloc/user_notification_bloc.dart';
import '../bloc/user_notification_events.dart';
import '../bloc/user_notification_states.dart';
import '../widgets/all_notifications.dart';
import '../widgets/empty_notification.dart';
import '../widgets/notification_item.dart' show NotificationItem;
import '../widgets/notification_loading.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notifications = [
    NotificationModel(
      createdAt: DateTime.now(),
      title: 'درس جديد في الجبر',
      message:
          'تمت إضافة درس جديد بعنوان "المعادلات التربيعية". يمكنك مشاهدته الآن ومتابعة الشرح خطوة بخطوة.',
    ),
    NotificationModel(
      createdAt: DateTime.now(),
      title: 'واجب جديد متاح',
      message:
          'تم نشر واجب في موضوع "النسب والتناسب". يُرجى حله قبل يوم الخميس القادم.',
    ),
    NotificationModel(
      createdAt: DateTime.now(),
      title: 'تذكير بالمراجعة',
      message:
          'لا تنسَ مراجعة دروس الهندسة قبل الاختبار الأسبوعي. المراجعة متوفرة في قسم الدروس.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Column(
          children: [
          TopScreenWidget(
          text: " الإشعارات",
          iconButton: IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: Colors.white,size: AppConstants.w*0.07,),
          ),
        ),BlocProvider(
          create:
              (context) =>
          UserNotificationBloc(getIt<GetUserNotificationsUseCase>())
            ..add(LoadUserNotifications()),
          child: BlocBuilder<UserNotificationBloc, UserNotificationState>(
            builder: (context, state) {
              if (state is UserNotificationLoading) {
                return NotificationLoading();

              } else if (state is UserNotificationLoaded) {
                return  state.notifications.isEmpty?

                EmptyNotificationsWidget():
                ShowAllNotificationScreen(
                  notifications: state.notifications,
                );
              } else if (state is UserNotificationFailure) {
                print("error : ${state.message}");
                return Center(child: Text(state.message));
              }
              return SizedBox();
            },
          ),
        ),
      ])),
    );
  }


}
