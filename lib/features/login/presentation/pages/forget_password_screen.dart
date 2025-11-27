import 'package:amr_rezk_education/features/login/presentation/bloc/login_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/intialization/init_di.dart';
import '../../../../core/sharedWidgets/app_snack_bar.dart';
import '../../../../core/sharedWidgets/custom_loading.dart';
import '../../../../core/sharedWidgets/main_wrapper.dart';
import '../../domain/use_cases/forget_password_use_case.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../bloc/bloc.dart';
import '../widgets/forget_password_item.dart';


class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => LoginBloc(
            loginUseCase: getIt<LoginUseCase>(),
            forgetPasswordUseCase: getIt<ForgetPasswordUseCase>(),
          ),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pop(context); // تغلق اللودينج

            AppSnackBar.showSuccess(
              context,
              "تم إرسال رابط إعادة التعيين! برجاء تفقد بريدك الإلكتروني والضغط على الرابط لإعادة ضبط كلمة المرور 🔐✉️",
            ); // Navigator.pop(context);
          }
          if (state is LoginFailure) {
            Navigator.pop(context); // تغلق اللودينج

            AppSnackBar.showError(context, state.error);
          }
          if (state is LoginLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (context) => const Dialog(
                    backgroundColor: Colors.transparent,
                    child: CustomLoadingWidget(),
                  ),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return  MainWrapper(
                childWidget:AbsorbPointer(
              absorbing: state is LoginLoading,
              child: Stack(
                children: [
                  ForgetPasswordItem(emailController: emailController),
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
