

 import '../../../../../core/handleErrors/result_pattern.dart';
import '../../models/notification_model.dart';

abstract class UserNotificationRemoteDS {
  Future<Result<List<NotificationModel>>> getUserNotifications();

}

