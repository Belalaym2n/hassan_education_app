  import '../../../../core/handleErrors/result_pattern.dart';
import '../../data/models/notification_model.dart';
import '../repositories/user_notification_repo.dart';

class GetUserNotificationsUseCase{
  final UserNotificationRepo repo;

  GetUserNotificationsUseCase(this.repo);

  Future<Result<List<NotificationModel>>> call() {
    return repo.getUserNotifications();
  }
}
