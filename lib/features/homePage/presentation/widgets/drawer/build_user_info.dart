import 'package:amr_rezk_education/core/cahsing/app_keys.dart';
import 'package:amr_rezk_education/core/cahsing/get_storage_helper.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/core/utils/texts_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class BuildUserInfo extends StatefulWidget {
  const BuildUserInfo({super.key});

  @override
  State<BuildUserInfo> createState() => _BuildUserInfoState();
}

class _BuildUserInfoState extends State<BuildUserInfo> {
  String? name;
  String? gmail;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _load_data();
    print(GetStorageHelper.read(AppKeys.name));
    print(GetStorageHelper.read(AppKeys.email));

    print("object$name");
  }
  Future<void> _load_data()async{
   await Future.delayed(Duration.zero, () {
      setState(() {
        name = GetStorageHelper.read(AppKeys.name);
        gmail = GetStorageHelper.read(AppKeys.email);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(0.0444 * AppConstants.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0.0444 * AppConstants.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 0.0277 * AppConstants.w,
                offset: Offset(0, 0.00515 * AppConstants.h),
              ),
            ],
          ),
          child:   Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppConstants.w * 0.025),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB2D9DB).withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    CupertinoIcons.person_crop_square,
                    size: AppConstants.w * 0.07,
                    color: AppColors.primaryColor, // اللون الأساسي (برتقالي فاتح)
                  ),
                ),
                SizedBox(width: 0.0144 * AppConstants.w),
                SizedBox(
                  width: AppConstants.w*0.28,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  buildUserName(),
                  buildUserEmail()

                ],

                ),

                ) ],
                ),
          );
  }

  buildUserName() {
    return Text(
      name??"User",
      style: AppTextStyles.headlineLarge()
    );
  }


  buildUserEmail() {
    return Text(
      overflow: TextOverflow.ellipsis,
      gmail??"***@gmail.com",
      style: AppTextStyles.bodyMedium()
    );
  }
}
