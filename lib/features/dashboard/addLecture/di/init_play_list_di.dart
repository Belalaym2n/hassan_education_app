// features/playlist/playlist_di.dart
import 'package:amr_rezk_education/features/dashboard/addLecture/data/data_sources/local/play_list_local.dart';
import 'package:amr_rezk_education/features/dashboard/addLecture/data/data_sources/local/play_list_local_ds_imp.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/data_sources/remote/playLIST/add_play_list_ds_imp.dart';
import '../data/data_sources/remote/playLIST/add_playlist_ds.dart';
import '../data/repositories/play_list_domain_repo.dart';
import '../domain/repositories/add_play_list_domain_repo.dart';
  import '../domain/use_cases/add_play_list_use_cases.dart';
import '../presentation/bloc/playListBloc/play_list_bloc.dart';



void playlistDI(GetIt getIt) {
  // Firestore already registered in your global DI (same as signUpDI)
  // but in case not:

  getIt.registerLazySingleton<PlaylistDS>(
        () => PlaylistDSImp(firestore: getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<PlayListLocalDS>(
        () => PlayListLocalDSImp( ),
  );
  getIt.registerLazySingleton<PlaylistDomainRepo>(
        () => PlaylistDataRepo(playlistDS: getIt<PlaylistDS>(),localDS: getIt()),
  );

  getIt.registerLazySingleton(() => AddLectureUseCase(repo: getIt<PlaylistDomainRepo>()));
  getIt.registerLazySingleton(() => GetLocalLecturesUseCase(repo: getIt<PlaylistDomainRepo>()));
  getIt.registerLazySingleton(() => RemoveLocalLectureUseCase(repo: getIt<PlaylistDomainRepo>()));
  getIt.registerLazySingleton(() => UploadLecturesUseCase(repo: getIt<PlaylistDomainRepo>()));

  getIt.registerFactory(
        () => PlaylistBloc(
      addLectureUseCase: getIt(),
      getLocalLecturesUseCase: getIt(),
      removeLocalLectureUseCase: getIt(),
      uploadLecturesUseCase: getIt(),
    ),
  );
}
