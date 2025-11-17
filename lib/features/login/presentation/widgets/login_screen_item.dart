import 'package:amr_rezk_education/config/routes/app_router.dart';
import 'package:amr_rezk_education/features/login/data/models/loginModel.dart';
import 'package:amr_rezk_education/features/login/presentation/bloc/bloc.dart';
import 'package:amr_rezk_education/features/login/presentation/bloc/login_states.dart';
import 'package:amr_rezk_education/features/signUp/data/models/auth_validation.dart';
import 'package:flutter/material.dart';
import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/sharedWidgets/buttons.dart';
import '../../../../core/sharedWidgets/custom_form_field.dart';
import '../bloc/loginEvents.dart';

class LoginScreenItem extends StatefulWidget {
  const LoginScreenItem({super.key});

  @override
  State<LoginScreenItem> createState() => LoginScreenState();
}

class  LoginScreenState extends State<LoginScreenItem> {
  final _formKey = GlobalKey<FormState>();
   final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_onFormChanged);
    _passwordController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    context.read<LoginBloc>().add(
      LoginFormChanged(
        email: _emailController.text,
        password: _passwordController.text,

      ),
    );
  }

  @override
  void dispose() {

    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final user = LoginModel(
          email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
       );

      context.read<LoginBloc>().add(LoginButtonPressed(model: user));
    }
  }

  bool isSecure = true;
  void clearForm() {
    _formKey.currentState?.reset(); // 🔥 تمسح كل الأخطاء


    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              final bool isButtonEnabled = state.isValid;

              return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
              key: _formKey,
              child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppConstants.h * 0.08),
              _headline(),
              _description(),
              SizedBox(height: AppConstants.h * 0.03),
              CustomTextFormField(
                controller: _emailController,
                validator: AuthValidator.validateEmail,
                label: "البريد الإلكتروني",
                hint: "example@email.com",
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextFormField(
                controller: _passwordController,
                validator: AuthValidator.validatePassword,
                label: "كلمة المرور",
                hint: "********",
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
              ),
              SizedBox(height: AppConstants.h * 0.02),
              _forgotPasswordText(),
              SizedBox(height: AppConstants.h * 0.2),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10.0,
                ),
                child: large_button(

                  buttonName: "تسجيل الدخول",
                  isDisable: !isButtonEnabled,
                  onPressed: isButtonEnabled
                      ? () => _onLoginPressed(context)
                      : null,
                ),
              ),
              _dontHaveAccountText(),
              SizedBox(height: AppConstants.h * 0.05),
            ],
          ),
          ) );})
      ),
    );
  }

  Widget _headline() => Text(
    "مرحبًا بعودتك 👋",
    style: TextStyle(
      fontWeight: FontWeight.w900,
      color: AppColors.primaryColor,
      fontSize: AppConstants.w * 0.07,
      letterSpacing: 0.6,
    ),
  );

  Widget _description() => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: AppConstants.w * 0.1,
      vertical: AppConstants.h * 0.01,
    ),
    child: Text(
      "سجّل دخولك للمتابعة واستمتع بتجربتك التعليمية معنا.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: AppConstants.w * 0.04,
        color: Colors.grey[700],
        height: 1.6,
      ),
    ),
  );

  Widget _forgotPasswordText() => Padding(
    padding: EdgeInsets.only(right: AppConstants.w * 0.08),
    child: Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          // انتقل إلى شاشة "نسيت كلمة المرور"
        },
        child: Text(
          "هل نسيت كلمة المرور؟",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: AppConstants.w * 0.038,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ),
  );

  Widget _dontHaveAccountText() => Padding(
    padding: EdgeInsets.only(top: AppConstants.h * 0.02),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.signUp);
            // انتقل إلى شاشة التسجيل
          },
          child: Text(
            "أنشئ حسابك الآن",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: AppConstants.w * 0.042,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SizedBox(width: AppConstants.w * 0.01),
        Text(
          "ليس لديك حساب؟ ",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: AppConstants.w * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
