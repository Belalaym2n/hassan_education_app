   import 'package:amr_rezk_education/features/splash/onBoarding/onBoardScreens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/cahsing/app_keys.dart';
import '../../../../core/cahsing/secure_storage.dart';
import '../../../bottomNav/bottomNavUser.dart';

class AutoLogin extends StatefulWidget {
  const AutoLogin({super.key});

  @override
  State<AutoLogin> createState() => _AutoLoginState();
}

class _AutoLoginState extends State<AutoLogin> {
  late String? userID;
  bool isLoading = true;

  checkUserLogin() async {
    final id = await SecureStorageHelper.read(AppKeys.userId);

    print("user  id $id");

    setState(() {
      userID = id;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    checkUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CupertinoActivityIndicator(); // أو أي لودينج ويدجت يعجبك
    }

    return userID != null ? BottomNav() : OnBoardScreen();
  }
}
