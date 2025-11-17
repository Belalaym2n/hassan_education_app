
import '../../../../core/handleErrors/result_pattern.dart';
import '../models/ownerModel.dart';

abstract class SignUpDS{
 Future<Result> createAcc(UserModel user);
 Future<Result> uploadUserOnFirebaseDatabase(UserModel user);
}