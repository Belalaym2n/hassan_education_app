import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppConstants {
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
      "os_v2_app_ztwyipvlzvd25nce5fd66m35dknf6qiwsecudqmm63ogb3dfzqbtxbzksnyg6w3qota2nhqqrs6zlrptkyoxr2zhqgun5wkfddfvmwi";
  static const String imageUrl = "assets/images/";

  static late double h;

  static late double w;

  static void initSize(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
  }
}

class StaticList {
  static final List<String> sections = [
    'الصف الرابع الابتدائي',
    'الصف الخامس الابتدائي',
    'الصف السادس الابتدائي',
    'الصف الأول الإعدادي',
    'الصف الثاني الإعدادي',
    'الصف الثالث الإعدادي',
    'الصف الأول الثانوي',
    'الصف الثاني الثانوي',
  ];

  static final List<String> roles = ["General manager", "FM"];
}
