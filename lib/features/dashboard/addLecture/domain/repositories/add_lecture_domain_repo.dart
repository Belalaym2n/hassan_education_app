
import '../../../../../core/handleErrors/result_pattern.dart';
import '../../data/models/lecture_model.dart';

abstract class AddLectureDomainRepo {
  Future<Result> addLecture({required LectureModel lecture});
}
