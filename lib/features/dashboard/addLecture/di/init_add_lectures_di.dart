// features/lectures/presentation/di/addLectureDI.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import '../data/data_sources/remote/singleLecture/add_lecture_ds.dart';
import '../data/data_sources/remote/singleLecture/add_lecture_dsr_imp.dart';
import '../data/repositories/add_lectures_data_repo.dart';
import '../domain/repositories/add_lecture_domain_repo.dart';
import '../domain/use_cases/add_lecture_use_case.dart';
 import '../presentation/bloc/lectureBloc/add_lectures_bloc.dart';

void addLectureDI(GetIt getIt) {
  // register firestore if not already registered in app DI


  getIt.registerLazySingleton<AddSingleLectureDS>(() =>
      AddLectureDSImp( firestore:  getIt()));

    getIt.registerLazySingleton<AddLectureDomainRepo>(() =>
        AddLectureDataRepo(getIt()));
  getIt.registerLazySingleton(() => AddLectureUseCase(repo: getIt()));
  getIt.registerFactory(() => AddLectureBloc(addLectureUseCase: getIt()));
}
