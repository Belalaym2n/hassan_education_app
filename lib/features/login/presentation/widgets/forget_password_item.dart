import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/sharedWidgets/buttons.dart';
import '../../../../core/sharedWidgets/custom_form_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../signUp/data/models/auth_validation.dart';
import '../bloc/bloc.dart';
import '../bloc/loginEvents.dart';

class ForgetPasswordItem extends StatefulWidget {
  final TextEditingController emailController;

  const ForgetPasswordItem({
    super.key,
    required this.emailController,
  });

  @override
  State<ForgetPasswordItem> createState() => _ForgetPasswordItemState();
}

class _ForgetPasswordItemState extends State<ForgetPasswordItem>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnim = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _scaleAnim = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  TextStyle get _titleStyle => TextStyle(
    fontSize: AppConstants.w * 0.056,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  TextStyle get _descriptionStyle => TextStyle(
    fontSize: AppConstants.w * 0.04,
    color: Colors.grey[600],
  );

  TextStyle get _backTextStyle => TextStyle(
    fontSize: AppConstants.w * 0.04,
    color: Colors.black87,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.05),
        child: FadeTransition(
          opacity: _fadeAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "نسيت كلمة المرور",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: AppConstants.h * 0.07),

          /// Icon Animation
          Center(
            child: Icon(
              Icons.lock_reset_rounded,
              size: AppConstants.w * 0.25,
              color: AppColors.primaryColor,
            ),
          ),

          SizedBox(height: AppConstants.h * 0.02),

          Center(
            child: Text("هل نسيت كلمة المرور؟", style: _titleStyle),
          ),

          SizedBox(height: AppConstants.h * 0.01),

          Center(
            child: Text(
              "أدخل بريدك الإلكتروني لإرسال رابط إعادة تعيين كلمة المرور.",
              textAlign: TextAlign.center,
              style: _descriptionStyle,
            ),
          ),

          SizedBox(height: AppConstants.h * 0.05),

          CustomTextFormField(
            validator: AuthValidator.validateEmail,
            label: "البريد الإلكتروني",
            hint: "example@email.com",
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            controller: widget.emailController,
          ),

          SizedBox(height: AppConstants.h * 0.04),

          large_button(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(
                  ForgetPasswordPressed(widget.emailController.text),
                );
              }
            },
            buttonName: "إعادة تعيين كلمة المرور",
          ),

          SizedBox(height: AppConstants.h * 0.02),

          _backButton(),
        ],
      ),
    );
  }

  Widget _backButton() {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(
        "العودة لتسجيل الدخول",
        style: _backTextStyle,
      ),
    );
  }
}
