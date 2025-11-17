import 'package:flutter/material.dart';
import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final bool isPassword;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isFocused = false;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.07,
        vertical: AppConstants.h * 0.012,
      ),
      child: Focus(
        onFocusChange: (focus) {
          setState(() => _isFocused = focus);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isFocused
                  ? AppColors.primaryColor.withOpacity(0.8)
                  : Colors.grey.shade300,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _isFocused
                    ? AppColors.primaryColor.withOpacity(0.25)
                    : Colors.black12,
                blurRadius: _isFocused ? 18 : 6,
                offset: Offset(0, _isFocused ? 6 : 3),
              ),
            ],
          ),
          child: TextFormField(


            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPassword && _obscure,
            validator: widget.validator,
            errorBuilder: (context, errorText) {
              return Padding(
                padding: EdgeInsets.only(
                  right:   AppConstants.w * 0.0,
                  left:   AppConstants.w * 0.07,
                  bottom: AppConstants.h * 0.012
                 ),
                child: Text(
                  errorText,
                  style: TextStyle(height: 0.2,
                      fontSize: AppConstants.w*0.03,
                      color: Colors.red),
                ),
              );
            },
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: AppConstants.w * 0.043,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: widget.label,
              labelStyle: TextStyle(
                color: _isFocused
                    ? AppColors.primaryColor
                    : AppColors.textSecondary,
                fontWeight: FontWeight.w700,
                fontSize: AppConstants.w * 0.038,
              ),
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: AppConstants.w * 0.035,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: _isFocused
                            ? AppColors.primaryColor.withOpacity(0.1)
                            : Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.prefixIcon,
                        color: _isFocused
                            ? AppColors.primaryColor
                            : Colors.grey[600],
                        size: 23,
                      ),
                    )
                  : null,
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: () {
                        setState(() => _obscure = !_obscure);
                      },
                      child: Icon(
                        _obscure
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: _isFocused
                            ? AppColors.primaryColor
                            : Colors.grey[500],
                      ),
                    )
                  : null,

              // 🔥 ثبّت مساحة الـ error تحت الحقل عشان ما يحصل تمدد
              errorMaxLines: 1,
              contentPadding: EdgeInsets.symmetric(
                vertical: AppConstants.h * 0.02,
                horizontal: AppConstants.w * 0.04,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


Widget  admin_field(String label, TextEditingController controller,

    {int maxLines = 1,      String? Function(String?)? validator,
    }) {
  return TextFormField(
    validator: validator,

    controller: controller,
    maxLines: maxLines,

    decoration: InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );
}