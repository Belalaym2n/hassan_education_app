
import '../../../../core/handleErrors/result_pattern.dart';
import '../../data/models/ownerModel.dart';

abstract class SignUpDomainRepo {
  Future<Result> createAcc({required UserModel user});
}
