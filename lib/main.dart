import 'dart:io';

import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'config/routes/app_router.dart';
import 'core/intialization/init_di.dart';
import 'features/notification/data/models/notification_model.dart';
import 'features/notification/presentation/widgets/notificationDetails.dart';
import 'firebase_options.dart';

// ⬇️ أضف هذه الـ imports
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDI();

  // ⬇️ السطر السحري لحل error 153
  OneSignal.initialize(AppConstants.oneSignalAppId);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    openNotification(navigatorKey);

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
      // يحتفظ فقط بأول شاشة (الشاشة الأخيرة قبل الإشعار)
    );
  });
}
