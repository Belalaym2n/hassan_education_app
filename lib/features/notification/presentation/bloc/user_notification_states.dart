import 'package:equatable/equatable.dart';

import '../../data/models/notification_model.dart';


abstract class UserNotificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserNotificationInitial extends UserNotificationState {}

class UserNotificationLoading extends UserNotificationState {}

class UserNotificationLoaded extends UserNotificationState {
  final List<NotificationModel> notifications;

  UserNotificationLoaded(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class UserNotificationFailure extends UserNotificationState {
  final String message;

  UserNotificationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
