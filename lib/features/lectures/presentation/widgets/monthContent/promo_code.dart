import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';

class PromoCode extends StatefulWidget {
  const PromoCode({super.key});

  @override
  State<PromoCode> createState() => _PromoCodeState();
}

class _PromoCodeState extends State<PromoCode> {
  final TextEditingController promoController = TextEditingController();
  bool isPromoValid = false;

  @override
  Widget build(BuildContext context) {
    return   Padding(
        padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.06,
        vertical: AppConstants.h * 0.02,
    ),
    child:Container(
      padding: EdgeInsets.all(AppConstants.w * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.w * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "أدخل كود الخصم لفتح جميع المحاضرات:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppConstants.w * 0.038,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: AppConstants.h * 0.012),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: promoController,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: "ادخل كود الخصم هنا",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(AppConstants.w * 0.03),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppConstants.w * 0.03),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.w * 0.05,
                    vertical: AppConstants.h * 0.014,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(AppConstants.w * 0.03),
                  ),
                ),
                onPressed: () {
                  if (promoController.text.trim() == "MATH2025") {
                    setState(() => isPromoValid = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("تم تفعيل الكود بنجاح ✅"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("الكود غير صحيح ❌"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text("تفعيل",style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
