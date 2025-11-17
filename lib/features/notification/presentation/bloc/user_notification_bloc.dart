  import 'package:amr_rezk_education/features/notification/presentation/bloc/user_notification_events.dart';
import 'package:amr_rezk_education/features/notification/presentation/bloc/user_notification_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/user_notifications_use_case.dart';

class UserNotificationBloc
    extends Bloc<UserNotificationEvent, UserNotificationState> {
  final GetUserNotificationsUseCase getUserNotificationsUseCase;

  UserNotificationBloc(this.getUserNotificationsUseCase)
      : super(UserNotificationInitial()) {
    on<LoadUserNotifications>(_onLoadNotifications);
  }

  Future<void> _onLoadNotifications(
      LoadUserNotifications event, Emitter<UserNotificationState> emit) async {
    emit(UserNotificationLoading());

    final result = await getUserNotificationsUseCase();

    if (result.isSuccess) {
      emit(UserNotificationLoaded(result.data!));
    } else {
      emit(UserNotificationFailure(result.error ?? "Failed to load notifications"));
    }
  }
}
