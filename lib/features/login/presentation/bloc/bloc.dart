import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../signUp/data/models/auth_validation.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/forget_password_use_case.dart';
import 'loginEvents.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;

  LoginBloc({required this.loginUseCase, required this.forgetPasswordUseCase})
    : super(const LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LoginFormChanged>(_onFormChanged);
    on<ForgetPasswordPressed>(_onForgetPasswordPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await loginUseCase(event.model);

    if (result.isSuccess) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure(result.error.toString()));
    }
    final isValid = _validateForm(
      email: event.model.email,
      password: event.model.password,
    );
    emit(LoginFormUpdated(isValid));
  }

  Future<void> _onForgetPasswordPressed(
    ForgetPasswordPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final result = await forgetPasswordUseCase(event.email);

    if (result.isSuccess) {
      emit(PasswordResetEmailSent());
    } else {
      emit(LoginFailure(result.error.toString()));
    }
  }

  void _onFormChanged(LoginFormChanged event, Emitter<LoginState> emit) {
    final isValid = _validateForm(email: event.email, password: event.password);
    emit(LoginFormUpdated(isValid));
  }

  bool _validateForm({required String email, required String password}) {
    return AuthValidator.validateEmail(email) == null &&
        AuthValidator.validatePassword(password) == null;
  }
}
