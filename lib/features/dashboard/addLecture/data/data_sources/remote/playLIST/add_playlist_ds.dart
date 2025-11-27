// features/playlist/data/data_sources/playlist_ds.dart

import '../../../../../../../core/handleErrors/result_pattern.dart';
import '../../../../../../lectures/data/models/play_list_model.dart';
import '../../../models/lecture_model.dart';

abstract class PlaylistDS {
  Future<Result> uploadLecturesToFirestore(
    List<LectureModel> lectures,
    String playlistId, {
    required String stage,
        required PlaylistModel model,
  });
}
