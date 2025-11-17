  import '../../../../core/handleErrors/result_pattern.dart';
import '../../data/models/notification_model.dart';

abstract class UserNotificationRepo {
  Future<Result<List<NotificationModel>>> getUserNotifications();
}
