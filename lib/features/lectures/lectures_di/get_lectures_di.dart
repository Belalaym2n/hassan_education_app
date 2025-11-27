import 'package:amr_rezk_education/features/lectures/domain/use_cases/get_all_play_lists.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/data_sources/remote/get_lect_ds.dart';
import '../data/data_sources/remote/get_lect_rds_imp.dart';
import '../data/repositories/get_lect_data_repo.dart';
import '../domain/repositories/get_lect_domain_repo.dart';
import '../domain/use_cases/get_lectures_use_case.dart';

void lecturesDI(GetIt getIt) {
  getIt.registerLazySingleton<GetLecturesDS>(
    () => GetLecturesDSImp(firestore: getIt()),
  );

  getIt.registerLazySingleton<GetLecturesDomainRepo>(
    () => GetLecturesDataRepo(getIt()),
  );

  getIt.registerLazySingleton(() => GetLecturesUseCase(repo: getIt()));
  getIt.registerLazySingleton(() => GetPlaylistsUseCase( getIt()));
}
