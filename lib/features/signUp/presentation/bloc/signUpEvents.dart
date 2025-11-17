import 'package:equatable/equatable.dart';
import '../../data/models/ownerModel.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// لما المستخدم يضغط زر التسجيل
class SignUpButtonPressed extends SignUpEvent {
  final UserModel user;
    SignUpButtonPressed(this.user);

  @override
  List<Object?> get props => [user];
}

class ChooseSectionEvent extends SignUpEvent{
  String sectionName;
  int  index;
  ChooseSectionEvent(this.sectionName,this.index);
}
/// لما المستخدم يغيّر أي حقل في الفورم
class SignUpFormChanged extends SignUpEvent {
  final String email;
  final String password;
  final String name;
  final String phone;

    SignUpFormChanged({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  @override
  List<Object?> get props => [email, password, name, phone];
}

