import 'package:get_it/get_it.dart';

import '../../features/dashboard/addLecture/di/init_add_lectures_di.dart';
import '../../features/dashboard/addLecture/di/init_play_list_di.dart';
import '../../features/lectures/lectures_di/get_lectures_di.dart';
import '../../features/login/di/login_di.dart';
import '../../features/notification/userNotificationDI/user_notification_di.dart';
import '../../features/signUp/di/signUpDi.dart';


final getIt = GetIt.instance;

Future<void> initDI() async {

  signUpDI(getIt);
  userNotificationInitDi(getIt);
  addLectureDI(getIt);
  initialLoginDI(getIt);
  lecturesDI(getIt);
  playlistDI(getIt);

}
