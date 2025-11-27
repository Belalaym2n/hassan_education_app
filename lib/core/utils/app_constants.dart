import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppConstants {
  static late double h;

  static late double w;

  static void initSize(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
  }

  static const String base_url = "https://accept.paymob.com/api";
  static const String auth_taken_enpoint = "/auth/tokens";
  static const String order_id_enpoint = "/ecommerce/orders";
  static const String oneSignalAPIURL =
      "https://onesignal.com/api/v1/notifications";

  static const appId = 1362999457;
  static const appSign =
      'e4e456c1a7e52109c3f05361598149731f15d42fe55697425f68db7d70ae89b7';
  static String oneSignalAppId = "cced843e-abcd-47ae-b444-e947ef337d1a";
  static String oneSignalApiKey =
      "os_v2_app_ztwyipvlzvd25nce5fd66m35djdkn6ljf23ufpmshyr4dt4fzvqhfdedom27pwrvgrnooeqz5p32mqmhqbdsardhisoxgd4a4bjqooq";
  static const String imageUrl = "assets/images/";
}

class StaticList {
  static final List<String> sections = [
    'الصف الأول الإعدادي',
    'الصف الثاني الإعدادي',
    'الصف الثالث الإعدادي',
    'الصف الأول الثانوي',
    'الصف الثاني الثانوي',
  ];

  static final List<String> roles = ["General manager", "FM"];
}
