import 'package:get_it/get_it.dart';
 import '../data/data_sources/remote/get_notification_rds.dart';
import '../data/data_sources/remote/get_notification_rds_imp.dart';
import '../data/repositories/get_notification_repo.dart';
import '../domain/repositories/user_notification_repo.dart';
  import '../domain/use_cases/user_notifications_use_case.dart';
import '../presentation/bloc/user_notification_bloc.dart';

void userNotificationInitDi(GetIt getIt) {
  // Data source
  getIt.registerLazySingleton<UserNotificationRemoteDS>(
          () => UserNotificationRemoteDSImpl());

  // Repo
  getIt.registerLazySingleton<UserNotificationRepo>(
          () => UserNotificationRepoImpl(getIt()));

  // UseCase
  getIt.registerLazySingleton(() => GetUserNotificationsUseCase(getIt()));

  // Bloc
  getIt.registerFactory(() => UserNotificationBloc(getIt()));
}
