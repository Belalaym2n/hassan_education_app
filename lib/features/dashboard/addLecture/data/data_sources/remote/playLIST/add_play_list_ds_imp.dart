// features/playlist/data/data_sources/playlist_ds_imp.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../../core/firebase/firebase_manager.dart';
import '../../../../../../../core/handleErrors/exaption_handler.dart';
import '../../../../../../../core/handleErrors/result_pattern.dart';
import '../../../../../../lectures/data/models/play_list_model.dart';
import '../../../models/lecture_model.dart';
import 'add_playlist_ds.dart';

class PlaylistDSImp implements PlaylistDS {
  final FirebaseFirestore firestore;

  PlaylistDSImp({required this.firestore});

  @override
  Future<Result> uploadLecturesToFirestore(
    List<LectureModel> lectures,
    String playlistId, {
    required String stage,
    required PlaylistModel model,
  }) async {
    final batch = firestore.batch();

    try {
      final playlistRef = firestore
          .collection("${stage}_Playlists")
          .doc(model.id);
      model.playListFirstVideo = lectures[0].videoUrl;

      batch.set(playlistRef, model.toJson());

      for (var lecture in lectures) {
        final docId = DateTime.now().millisecondsSinceEpoch.toString();
        final docRef = playlistRef.collection("Lectures").doc(docId);

        batch.set(docRef, lecture.toJson());
      }

      await batch.commit();
      return Result.success("uploaded_all");
    } catch (e) {
      print("error ${e.toString()}");
      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }
}
