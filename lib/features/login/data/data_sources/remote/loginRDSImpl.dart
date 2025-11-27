import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../config/configeration/app_configeration.dart';
import '../../../../../core/cahsing/app_keys.dart';
import '../../../../../core/cahsing/get_storage_helper.dart';
import '../../../../../core/cahsing/secure_storage.dart';
import '../../../../../core/firebase/firebase_manager.dart';
import '../../../../../core/handleErrors/exaption_handler.dart';
import '../../../../../core/handleErrors/result_pattern.dart';
import '../../../../signUp/data/models/ownerModel.dart';
import '../../models/loginModel.dart';
import 'loginRDS.dart';

class LoginRDSImpl implements LoginRDS {
  final FirebaseAuth auth;

  LoginRDSImpl({required this.auth});

  @override
  Future<Result> login(LoginModel model) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );

      final dataResult = await getUserData(credential.user!.uid);
      if (dataResult.isSuccess) {
        await saveUserData(dataResult.data);
        return   Result.success("go to login");
      } else {
        print("get data error ${dataResult.error.toString()}");
        return Result.failure(dataResult.error ?? "Failed to load user data");
      }
    } catch (e) {
      print("error ${e.toString()}");
      final exception = ExceptionHandler.handle(e);
      print("exception ${exception.message}");
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }

  @override
  Future<Result> sendPasswordResetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return   Result.success("Password reset email sent.");
    } catch (e) {
      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }

  @override
  Future<Result> getUserData(String userId) async {
    final collectionName=AppConfiguration.userCollectionName;

    try {
      final ownersCollection = FirebaseManager.getCollection<UserModel>(
        collectionName: collectionName,
        fromJson: (json) => UserModel.fromJson(json),
        toJson: (model) => model.toJson(),
      );

      final docSnapshot = await ownersCollection.doc(userId).get();
      if (docSnapshot.exists) {
        final user = docSnapshot.data();
        return Result.success(user);
      } else {
        return   Result.failure("User not found");
      }
    } catch (e) {
       print("err${e.toString()}");

       final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }

  @override
  Future<Result> saveUserData(UserModel user) async {
    try {
      await SecureStorageHelper.write(AppKeys.userId, user.userID);
      print("🔥 Firestore User Name = ${user.name}");
      await GetStorageHelper.write(AppKeys.name, user.name ?? "");
      await GetStorageHelper.write(AppKeys.email, user.gmail ?? "");

      await GetStorageHelper.write(
        AppKeys.phone,
        user.phoneNumber ?? "",
      );
      await GetStorageHelper.write(
        AppKeys.stage,
        user.section ?? "",
      );
      print("stage ${GetStorageHelper.read(AppKeys.name)}");
      return   Result.success("data has been saved");
    } catch (e) {
      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }

 }
