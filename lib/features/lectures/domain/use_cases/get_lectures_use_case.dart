import '../../../../core/handleErrors/result_pattern.dart';
 import '../repositories/get_lect_domain_repo.dart';

class GetLecturesUseCase {
  final GetLecturesDomainRepo repo;

  GetLecturesUseCase({required this.repo});

  Future<Result> call() async {
    final result = await repo.getLectures();

    if (result.isSuccess) {
      return Result.success(result.data);
    } else {
      return Result.failure(result.error);
    }
  }
}
