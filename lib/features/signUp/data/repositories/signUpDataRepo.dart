
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/handleErrors/result_pattern.dart' show Result;
import '../../domain/repositories/signUpDomainRep.dart';
import '../data_sources/signUpDS.dart';
import '../models/ownerModel.dart';

class SignUpDataRepo implements SignUpDomainRepo {
  SignUpDS signUpDS;
  SignUpDataRepo(this.signUpDS);
  @override
  Future<Result> createAcc({required UserModel user}) {
    // TODO: implement createAcc
    return signUpDS.createAcc(user);
  }

}