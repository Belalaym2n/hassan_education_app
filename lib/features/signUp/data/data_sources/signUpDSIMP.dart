import 'package:amr_rezk_education/config/configeration/app_configeration.dart';
import 'package:amr_rezk_education/features/signUp/data/data_sources/signUpDS.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/handleErrors/exaption_handler.dart';
import '../../../../core/handleErrors/result_pattern.dart';
import '../models/ownerModel.dart';

class SignUpDSImp implements SignUpDS {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  SignUpDSImp({required this.auth, required this.firestore});

  @override
  Future<Result> createAcc(UserModel userModel) async {
    User? user; // 👈 خليه متاح على مستوى الدالة كلها

    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: userModel.gmail,
        password: userModel.password,
      );
      user = credential.user;

      if (user != null) {
        userModel.userID = user.uid;
        try {
          await uploadUserOnFirebaseDatabase(userModel);
          return Result.success("Create account successfully!");
        } catch (e) {
          // ⚠️ هنا لو فشل رفع الداتا في Firestore
          await user.delete();
          final exception = ExceptionHandler.handle(e);
          final failure = ExceptionHandler.exceptionToFailure(
            exception,
          ); // 👈 rollback فعلي
          return Result.failure(failure.message.toString());
        }
      }

      return Result.failure("Failed to create user.");
    } catch (e) {
      if (user != null) {
        try {
          await user.delete();
        } catch (_) {}
      }

      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }

  @override
  Future<Result> uploadUserOnFirebaseDatabase(UserModel user) async {
    final collectionName=AppConfiguration.userCollectionName;
    // TODO: implement uploadUserOnFirebaseDatabase
    try {
      await

      firestore.collection(collectionName).doc(user.userID).set(user.toJson());

      return Result.success("success");
    } catch (e) {
      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }
}
