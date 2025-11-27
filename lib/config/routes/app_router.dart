import 'package:amr_rezk_education/features/dashboard/home/dash_board_home.dart';
import 'package:amr_rezk_education/features/login/presentation/pages/auto_login_screen.dart';
import 'package:amr_rezk_education/features/login/presentation/pages/forget_password_screen.dart';
import 'package:amr_rezk_education/features/login/presentation/pages/login_screen.dart';
import 'package:amr_rezk_education/features/login/presentation/widgets/login_screen_item.dart';
import 'package:amr_rezk_education/features/notification/presentation/pages/notification_screen.dart';
import 'package:amr_rezk_education/features/signUp/presentation/pages/signUpScreen.dart';
import 'package:amr_rezk_education/features/splash/onBoarding/onBoardScreens.dart';
import 'package:amr_rezk_education/features/splash/splashScreen/splashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/bottomNav/bottomNavUser.dart';
import '../../features/dashboard/addLecture/presentation/widgets/questionOfLectureType/lectures_type_question.dart';
import '../../features/homePage/presentation/pages/home_page.dart';

class AppRoutes {
  // codia Admin
  static const String homePage = "HomePage/";
  static const String bottomNav = "lectures/";
  static const String signUp = "signUp/";
  static const String login = "login/";
  static const String forgetPassword = "forgetPassword/";
  static const String onBoard = "sfsf/";
  static const String notification = "notification/";
  static const String autoLogin = "autoLogin/";
  static const String splash = "/";
  static const String lectures = "sdf/";

  // security
}

class Routes {
  static onGenerate(RouteSettings setting) {
    switch (setting.name) {
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (context) => SignUpScreen());

      case AppRoutes.forgetPassword:
        return MaterialPageRoute(builder: (context) => ForgetPasswordScreen());
      case AppRoutes.lectures:
        return MaterialPageRoute(builder: (context) => LecturesTypeQuestion());

      case AppRoutes.autoLogin:
        return MaterialPageRoute(builder: (context) => AutoLogin());

      case AppRoutes.notification:
        return MaterialPageRoute(builder: (context) => NotificationScreen());

      case AppRoutes.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case AppRoutes.onBoard:
        return MaterialPageRoute(builder: (context) => OnBoardScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      // security
      case AppRoutes.homePage:
        return MaterialPageRoute(builder: (context) => HomePageScreen());

      case AppRoutes.bottomNav:
        return MaterialPageRoute(builder: (context) => BottomNav());

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(title: const Text("error")),
              body: unDefinedRoute(),
            );
          },
        );
    }
  }

  static Widget unDefinedRoute() {
    return const Center(child: Text("Route Not Found"));
  }
}
