import 'package:amr_rezk_education/features/signUp/data/models/ownerModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/handleErrors/result_pattern.dart';
import '../../models/loginModel.dart';

abstract class LoginRDS {
  Future<Result> login(LoginModel model);

  Future<Result> sendPasswordResetEmail(String email); // ✅
  Future<Result> getUserData(String userId); // ✅
  Future<Result> saveUserData(UserModel userId); // ✅
}
