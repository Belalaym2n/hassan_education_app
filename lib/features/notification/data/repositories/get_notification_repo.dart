
 import '../../../../core/handleErrors/result_pattern.dart';
import '../../domain/repositories/user_notification_repo.dart';
import '../data_sources/remote/get_notification_rds.dart';
import '../models/notification_model.dart';

class UserNotificationRepoImpl implements UserNotificationRepo {
  final UserNotificationRemoteDS remoteDS;

  UserNotificationRepoImpl(this.remoteDS);

  @override
  Future<Result<List<NotificationModel>>> getUserNotifications() {
    return remoteDS.getUserNotifications();
  }
}
