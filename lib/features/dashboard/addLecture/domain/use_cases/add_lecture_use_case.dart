
import '../../../../../core/handleErrors/result_pattern.dart';
import '../../data/models/lecture_model.dart';
import '../repositories/add_lecture_domain_repo.dart';

class AddLectureUseCase {
  final AddLectureDomainRepo repo;
  AddLectureUseCase({required this.repo});

  Future<Result> call({required LectureModel lecture}) async {
    final result = await repo.addLecture(lecture: lecture);
    if (result.isSuccess) {
      return Result.success(result.data);
    } else {
      return Result.failure(result.error);
    }
  }
}
