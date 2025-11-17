import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  final bool isValid;
  const LoginState({this.isValid = false});

  @override
  List<Object?> get props => [isValid];
}

class LoginInitial extends LoginState {
  const LoginInitial() : super(isValid: false);
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;
  const LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}

 class LoginFormUpdated extends LoginState {
  const LoginFormUpdated(bool isValid) : super(isValid: isValid);
}

 class PasswordResetEmailSent extends LoginState {}
