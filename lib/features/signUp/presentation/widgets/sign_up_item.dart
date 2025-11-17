import 'package:amr_rezk_education/features/signUp/data/models/ownerModel.dart';
import 'package:flutter/material.dart';
import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../core/sharedWidgets/buttons.dart';
import '../../../../core/sharedWidgets/custom_form_field.dart';
import '../../../../core/sharedWidgets/selected_section.dart';
import '../../data/models/auth_validation.dart';
import '../bloc/bloc.dart';
import '../bloc/signUpEvents.dart';
import '../bloc/signUpStates.dart';

class SignUpItem extends StatefulWidget {
  SignUpItem({super.key});

  @override
  State<SignUpItem> createState() => SignUpItemState();
}

class SignUpItemState extends State<SignUpItem> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onFormChanged);
    _phoneController.addListener(_onFormChanged);
    _emailController.addListener(_onFormChanged);
    _passwordController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    context.read<SignUpBloc>().add(
      SignUpFormChanged(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        phone: _phoneController.text,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignUpPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      print(context.read<SignUpBloc>().sectionName);
      final user = UserModel(
        userID: '',
        section: context.read<SignUpBloc>().sectionName.toString(),

        name: _nameController.text.trim(),
        gmail: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
      );

      context.read<SignUpBloc>().add(SignUpButtonPressed(user));
    }
  }

  bool isSecure = true;

  void clearForm() {
    _formKey.currentState?.reset(); // 🔥 تمسح كل الأخطاء

    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            final bool isButtonEnabled = state.isValid;

            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: AppConstants.h * 0.04),
                    _headline(),
                    _description(),
                    SizedBox(height: AppConstants.h * 0.02),
                    CustomTextFormField(
                      controller: _nameController,
                      label: "الاسم الكامل",
                      hint: "أدخل اسمك الكامل",
                      prefixIcon: Icons.person_outline,
                      validator: AuthValidator.validateField,
                    ),
                    CustomTextFormField(
                      controller: _phoneController,
                      label: "رقم الهاتف",
                      keyboardType: TextInputType.phone,
                      hint: "أدخل رقم هاتفك",
                      prefixIcon: Icons.phone_outlined,
                      validator: AuthValidator.validatePhone,
                    ),

                    CustomTextFormField(
                      controller: _emailController,
                      label: "البريد الإلكتروني",
                      hint: "example@email.com",
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: AuthValidator.validateEmail,
                    ),

                    CustomTextFormField(
                      controller: _passwordController,
                      label: "كلمة المرور",
                      hint: "********",
                      prefixIcon: Icons.lock_outline_rounded,
                      isPassword: true,
                      validator: AuthValidator.validatePassword,
                    ),
                    SizedBox(height: AppConstants.h * 0.01),
                    SelectedSection(
                      items: StaticList.sections,

                      index: context.watch<SignUpBloc>().index,
                      itemName: context.watch<SignUpBloc>().sectionName,
                      selectItem: (compoundName, index) {
                        context.read<SignUpBloc>().add(
                          ChooseSectionEvent(compoundName, index),
                        );

                        print("selected company: $compoundName");
                      },
                    ),
                    SizedBox(height: AppConstants.h * 0.03),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 0.0,
                      ),
                      child: large_button(
                        buttonName: "تسجيل الآن",
                        isDisable: !isButtonEnabled,
                        onPressed: isButtonEnabled
                            ? () => _onSignUpPressed(context)
                            : null,
                      ),
                    ),
                    SizedBox(height: AppConstants.h * 0.01),

                    _alreadyHaveAccountText(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _headline() => Text(
    "إنشاء حساب جديد",
    style: TextStyle(
      fontWeight: FontWeight.w900,
      color: AppColors.primaryColor,
      fontSize: AppConstants.w * 0.065,
      letterSpacing: 0.5,
    ),
  );

  Widget _description() => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: AppConstants.w * 0.1,
      vertical: AppConstants.h * 0.01,
    ),
    child: Text(
      "انضم إلينا الآن وابدأ رحلتك التعليمية مع تجربة استخدام سهلة وممتعة.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: AppConstants.w * 0.04,
        color: Colors.grey[700],
        height: 1.6,
      ),
    ),
  );

  Widget _alreadyHaveAccountText() => Padding(
    padding: EdgeInsets.only(top: AppConstants.h * 0.015),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.login);

            // انتقل إلى شاشة تسجيل الدخول هنا
            // Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
          },
          child: Text(
            "سجّل الدخول الآن",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: AppConstants.w * 0.042,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Text(
          "لديك حساب بالفعل؟ ",
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
