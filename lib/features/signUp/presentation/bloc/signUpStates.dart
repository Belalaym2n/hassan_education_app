import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  final bool isValid;
   const SignUpState({this.isValid = false});

  @override
  List<Object?> get props => [isValid];
}

class SignUpInitial extends SignUpState {
  const SignUpInitial() : super(isValid: false);
}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;
  const SignUpFailure(this.error);
  @override
  List<Object?> get props => [error];
}
class SectionSelectedState extends SignUpState {
  final String sectionName;
  final int index;

  SectionSelectedState({
    required this.sectionName,
    required this.index,
  });
}
/// حالة مخصصة للتحديث الفوري للفورم
class SignUpFormUpdated extends SignUpState {
  const SignUpFormUpdated(bool isValid) : super(isValid: isValid);
}
