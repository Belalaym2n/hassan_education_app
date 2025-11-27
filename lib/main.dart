import 'dart:io';

import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'config/configeration/app_configeration.dart';
import 'config/routes/app_router.dart';

import 'features/notification/data/models/notification_model.dart';
import 'features/notification/presentation/widgets/notificationDetails.dart';



class MyApp extends StatelessWidget {
    MyApp({super.key, required this.flavor});
  final String flavor;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    openNotification(navigatorKey);
    AppConfiguration.flavor = flavor; // هنستخدمها في أي مكان

    AppConstants.initSize(context);
    return MaterialApp(
      navigatorKey: navigatorKey,

      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: (settings) => Routes.onGenerate(settings),
    );
  }
}

openNotification(GlobalKey<NavigatorState> navigatorKey) {
  return OneSignal.Notifications.addClickListener((event) {
    final notification = event.notification;
    NotificationModel notifications = NotificationModel(
      createdAt: DateTime.now(),

      message: notification.body.toString(),
      title: notification.title.toString(),
    );
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) =>
            NotificationDetailed(notificationModel: notifications),
      ),
      (route) => route.isFirst,
    );
  });
}
