 import '../../../../../../core/handleErrors/result_pattern.dart';
import '../../models/lecture_model.dart';

abstract class PlayListLocalDS{
   Future<Result> addLocalLecture(LectureModel lecture);
   Future<Result> getLocalLectures();
   Future<Result> removeLocalLecture(String id);
   Future<Result> clearLocalLectures();
  }

