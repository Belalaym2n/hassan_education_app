import 'package:flutter/material.dart';
import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';

class OnBoardButtons extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final bool isLastPage;
    bool isLoading;

    OnBoardButtons({
    super.key,
    required this.onNext,
    required this.isLoading,
    required this.onBack,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.08,
        vertical: AppConstants.h * 0.025,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // زر التخطي
          Expanded(
            child: ElevatedButton(
              onPressed: onBack,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(color: AppColors.primaryColor, width: 1.2),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: AppConstants.h * 0.018,
                ),
              ),
              child: Text(
                !isLastPage ? "تخطي":"عودة ",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: AppConstants.w * 0.04,
                ),
              ),
            ),
          ),
          SizedBox(width: AppConstants.w * 0.04),

          // زر التالي أو ابدأ
          Expanded(
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: AppConstants.h * 0.018,
                ),
              ),
              child:   isLoading?SizedBox(
                width: AppConstants.w * 0.07,  // 👈 حجم أصغر
                height: AppConstants.w * 0.07,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,

                  // 👈 تخلي الخط أنحف وأنيق
                  color: Colors.white,
                ),
              ):Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLastPage ? "ابدأ الآن" : "التالي",
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: AppConstants.w * 0.04,
                    ),
                  ),
                  if (!isLastPage) const SizedBox(width: 6),
                  if (!isLastPage)
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.secondaryColor,
                      size: 22,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
