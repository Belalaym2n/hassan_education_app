// features/playlist/domain/repositories/playlist_domain_repo.dart
import '../../../../../core/handleErrors/result_pattern.dart';
 import '../../data/models/lecture_model.dart';

abstract class PlaylistDomainRepo {
  Future<Result> addLocalLecture(LectureModel lecture);
  Future<Result> getLocalLectures();
  Future<Result> removeLocalLecture(String id);
  Future<Result> clearLocalLectures();
  Future<Result> uploadLectures(List<LectureModel> lectures, String playlistId);
}
