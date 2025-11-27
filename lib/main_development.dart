import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'core/intialization/init_di.dart';
import 'core/utils/app_constants.dart';
import 'firebase_options.dart';
import 'main.dart';

Future<void> main() async {
  const flavor = 'development';
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDI();
  GetStorage.init();


  // ⬇️ السطر السحري لحل error 153
  OneSignal.initialize(AppConstants.oneSignalAppId);
  runApp(MyApp(flavor: flavor));
}
