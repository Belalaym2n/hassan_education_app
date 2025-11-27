import 'package:amr_rezk_education/features/signUp/domain/use_cases/signUpCall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/intialization/init_di.dart';
import '../../../../core/sharedWidgets/app_snack_bar.dart';
import '../../../../core/sharedWidgets/custom_loading.dart';
import '../../../../core/sharedWidgets/main_wrapper.dart';
import '../bloc/bloc.dart';
import '../bloc/signUpStates.dart';
import '../widgets/sign_up_item.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpItemKey = GlobalKey<SignUpItemState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(signUpUseCase: getIt<SignUpUseCase>()),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) async {
          if (state is SignUpLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Dialog(
                backgroundColor: Colors.transparent,
                child: CustomLoadingWidget(),
              ),
            );
          } else if (state is SignUpSuccess) {
            Navigator.pop(context); // تغلق اللودينج

            AppSnackBar.showSuccess(context, "تم إنشاء حسابك… أهلاً بك معنا!");
            await Future.delayed(Duration(milliseconds: 2000), () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login,(route) =>false ,);
            });
            signUpItemKey.currentState?.clearForm();

          } else if (state is SignUpFailure) {
            Navigator.pop(context); // تغلق اللودينج

            AppSnackBar.showError(context, state.error);
          }
        },

        builder: (context, state) {
          return MainWrapper(
            childWidget: AbsorbPointer(
              absorbing: state is SignUpLoading,
              child: Stack(children: [SignUpItem(key: signUpItemKey)]),
            ),
          );
        },
      ),
    );
  }
}
