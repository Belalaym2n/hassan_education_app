// features/lectures/data/data_sources/addLectureDS.dart
import '../../../../../../../core/handleErrors/result_pattern.dart';
 import '../../../../../home/dash_board_home.dart';
import '../../../models/lecture_model.dart';

abstract class AddSingleLectureDS {
  Future<Result> addLecture(LectureModel lecture);
}
