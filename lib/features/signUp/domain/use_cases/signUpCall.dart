import '../../../../core/handleErrors/result_pattern.dart';
import '../../data/models/ownerModel.dart';
import '../repositories/signUpDomainRep.dart';

class SignUpUseCase {
  SignUpDomainRepo signUpDomainRepo;

  SignUpUseCase({required this.signUpDomainRepo});

  Future<Result> call({required UserModel user}) async {
    final result = await signUpDomainRepo.createAcc(user: user);

    if (result.isSuccess) {
      return Result.success(result.data);
    } else {
      return Result.failure(result.error);
    }
  }
}
