// features/playlist/data/data_sources/playlist_ds.dart


import '../../../../../../../core/handleErrors/result_pattern.dart';
import '../../../models/lecture_model.dart';

abstract class PlaylistDS {
  Future<Result> uploadLectureToFirestore(LectureModel lecture, String playlistId);
  Future<Result> uploadLecturesToFirestore(List<LectureModel> lectures, String playlistId);
}
