 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

 import '../data/data_sources/signUpDS.dart';
import '../data/data_sources/signUpDSIMP.dart';
import '../data/repositories/signUpDataRepo.dart';
import '../domain/repositories/signUpDomainRep.dart';
import '../domain/use_cases/signUpCall.dart';
import '../presentation/bloc/bloc.dart';

void signUpDI(GetIt getIt) {
   getIt.registerLazySingleton(() => FirebaseFirestore.instance);
   getIt.registerLazySingleton(() => FirebaseAuth.instance);


   getIt.registerLazySingleton<SignUpDS>(
        () => SignUpDSImp(
      auth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
     ),
  );

   getIt.registerLazySingleton<SignUpDomainRepo>(
        () => SignUpDataRepo(getIt()),
  );

   getIt.registerLazySingleton(
        () => SignUpUseCase(signUpDomainRepo: getIt()),
  );

   getIt.registerFactory(
        () => SignUpBloc( signUpUseCase:  getIt(),),
  );
}
