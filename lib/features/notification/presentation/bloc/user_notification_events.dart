import 'package:equatable/equatable.dart';

abstract class UserNotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUserNotifications extends UserNotificationEvent {}
