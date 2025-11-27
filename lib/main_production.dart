import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'core/intialization/init_di.dart';
import 'core/utils/app_constants.dart';
import 'firebase_options.dart';
import 'main.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  const flavor = 'production';
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDI();
  GetStorage.init();

  await SentryFlutter.init((options) {
    options.dsn =
        "https://000f9c7ae3ddac4e69b41021aff728ca@o4508100777082880.ingest.us.sentry.io/4510437292310528";
    options.sendDefaultPii = true;
  }, appRunner: () => runApp(SentryWidget(child: MyApp(flavor: flavor))));

  // ⬇️ السطر السحري لحل error 153
  OneSignal.initialize(AppConstants.oneSignalAppId);
  runApp(MyApp(flavor: flavor));
}
