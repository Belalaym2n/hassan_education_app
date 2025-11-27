import 'package:flutter/material.dart';
import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

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

class _CustomTextFormFieldState extends State<CustomTextFormField>
    with SingleTickerProviderStateMixin {
  bool _isFocused = false;
  bool _obscure = true;

  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.0,
        vertical: AppConstants.h * 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Focus(
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
                      : (_errorText != null
                      ? Colors.redAccent
                      : Colors.grey.shade300),
                  width: 1.6,
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

                validator: (value) {
                  final result = widget.validator?.call(value);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() => _errorText = result);
                    }
                  });
                  return result; // ← مهم جدًا
                },
                // ← أضف هذا السطر
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                obscureText: widget.isPassword && _obscure,
                onChanged: (value) {
                  final result = widget.validator?.call(value);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() => _errorText = result);
                    }
                  });
                },

                errorBuilder: null,

                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: AppConstants.w * 0.04,
                ),
                decoration: InputDecoration(
                  errorText: null,

                  error: null,
                  errorStyle: TextStyle(
                      fontSize: 0
                  ),

                  border: InputBorder.none,
                  labelText: widget.label,
                  labelStyle: TextStyle(
                    color: _isFocused
                        ? AppColors.primaryColor
                        : AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: AppConstants.w * 0.035,
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
                  contentPadding: EdgeInsets.symmetric(
                    vertical: AppConstants.h * 0.02,
                    horizontal: AppConstants.w * 0.04,
                  ),
                ),
              ),
            ),
          ),

          // 🎨 Animated Error Bubble
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeIn,
            child: _errorText == null ?
            SizedBox(height: AppConstants.h * 0.01)
                : _build_error_widget(_errorText
            ),
          ),
        ],
      ),
    );
  }

  Widget _build_error_widget(String ?error) {
    return Padding(
      padding: EdgeInsets.only(top: AppConstants.h * 0.008),
      child: Container(
        key: ValueKey(_errorText ?? error??""),
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.w * 0.04,
          vertical: AppConstants.h * 0.008,
        ),
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.redAccent, width: 1),
        ),
        child: Text(
          _errorText ?? error??"",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.w600,
            fontSize: AppConstants.w * 0.032,
          ),
        ),
      ),
    );
  }
}

Widget admin_field(
  String label,

  TextEditingController controller, {
  int maxLines = 1,
      TextInputType? textInput,

      String? Function(String?)? validator,
}) {
  return TextFormField(
    keyboardType: textInput ?? TextInputType.text,
    validator: validator,

    controller: controller,
    maxLines: maxLines,

    decoration: InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
