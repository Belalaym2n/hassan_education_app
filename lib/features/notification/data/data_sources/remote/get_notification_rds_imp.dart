import 'dart:convert';

import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/features/notification/data/data_sources/remote/get_notification_rds.dart';
import 'package:amr_rezk_education/features/notification/presentation/widgets/notificationDetails.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../../core/handleErrors/exaption_handler.dart';
import '../../../../../core/handleErrors/result_pattern.dart';
import '../../models/notification_model.dart';

class UserNotificationRemoteDSImpl implements UserNotificationRemoteDS {
  @override
  Future<Result<List<NotificationModel>>> getUserNotifications() async {
    try {


      final response = await http.get(
        Uri.parse(
          "https://onesignal.com/api/v1/notifications?app_id=${AppConstants.oneSignalAppId}",
        ),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Basic ${AppConstants.oneSignalApiKey}",
        },
      );
      if (response.statusCode != 200) {
        print("error ${response.statusCode}");
        return Result.failure("Something went wrong !, please try again");
      }

      final data = jsonDecode(response.body);
      final List rawList = data["notifications"] ?? [];

      final notifications = rawList
          .map((n) => NotificationModel.fromJson(n))
          .toList();

      return Result.success(notifications);
    } catch (e) {
      print("error 7sl ${e.toString()}");
      final exception = ExceptionHandler.handle(e);
      print("exception 7sl  ${exception.message}");
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }
}
