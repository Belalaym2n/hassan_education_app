import 'package:amr_rezk_education/features/signUp/presentation/bloc/signUpEvents.dart';
import 'package:amr_rezk_education/features/signUp/presentation/bloc/signUpStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/auth_validation.dart';
import '../../domain/use_cases/signUpCall.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  String sectionName = "اختر المرحلة";
  int index = -1;
  String currentEmail = "";
  String currentPassword = "";
  String currentName = "";
  String currentPhone = "";

  SignUpBloc({required this.signUpUseCase}) : super(const SignUpInitial()) {
    on<SignUpButtonPressed>(_onSignUpButtonPressed);
    on<SignUpFormChanged>(_onFormChanged);
    on<ChooseSectionEvent>((event, emit) {
      sectionName = event.sectionName;
      index = event.index;

      emit(SectionSelectedState(sectionName: sectionName, index: index));
      final isValid = _validateForm(
        email: currentEmail, // هنعرفهم تحت
        password: currentPassword,
        name: currentName,
        phone: currentPhone,
      );

      emit(SignUpFormUpdated(isValid));
    });
  }

  Future<void> _onSignUpButtonPressed(
    SignUpButtonPressed event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    final result = await signUpUseCase(user: event.user);

    if (result.isSuccess) {
      emit(SignUpSuccess());
      sectionName = "اختر المرحلة";
    } else {
      emit(SignUpFailure(result.error.toString()));
    }

    final isValid = _validateForm(
      email: currentEmail,
      password: currentPassword,
      name: currentName,
      phone: currentPhone,
    );

    emit(SignUpFormUpdated(isValid));
  }

  void _onFormChanged(SignUpFormChanged event, Emitter<SignUpState> emit) {
    currentEmail = event.email;
    currentPassword = event.password;
    currentName = event.name;
    currentPhone = event.phone;

    final isValid = _validateForm(
      email: currentEmail,
      password: currentPassword,
      name: currentName,
      phone: currentPhone,
    );

    emit(SignUpFormUpdated(isValid));
  }

  bool _validateForm({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    return AuthValidator.validateEmail(email) == null &&
        AuthValidator.validatePassword(password) == null &&
        AuthValidator.validateField(name) == null &&
        sectionName != "اختر المرحلة" &&
        AuthValidator.validatePhone(phone) == null;
  }
}
