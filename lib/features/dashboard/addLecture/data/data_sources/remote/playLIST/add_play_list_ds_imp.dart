// features/playlist/data/data_sources/playlist_ds_imp.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../../core/firebase/firebase_manager.dart';
import '../../../../../../../core/handleErrors/exaption_handler.dart';
import '../../../../../../../core/handleErrors/result_pattern.dart';
import '../../../models/lecture_model.dart';
import 'add_playlist_ds.dart';

class PlaylistDSImp implements PlaylistDS {
  final FirebaseFirestore firestore;
  final String collectionName; // ex: "Playlists" or "Lectures"

  PlaylistDSImp({required this.firestore, this.collectionName = "Playlists"});

  @override
  Future<Result> uploadLectureToFirestore(LectureModel lecture, String playlistId) async {
    try {
      final docId = DateTime.now().millisecondsSinceEpoch
          .toString();


      lecture.id=docId;
      await FirebaseManager.uploadModel<LectureModel>(
          collectionName: "Lectures",
          model: lecture,
          docId: docId,
          toJson: (e) => e.toJson(),
          fromJson: (json) => LectureModel.fromJson(json)
      );
      return Result.success("uploaded");
    } catch (e) {
      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }


  @override
  Future<Result> uploadLecturesToFirestore(List<LectureModel> lectures, String playlistId) async {
    final batch = firestore.batch();
    try {
      final collRef = firestore.collection(collectionName).doc(playlistId).collection(playlistId);
      for (var lecture in lectures) {
        final docId = DateTime.now().millisecondsSinceEpoch
            .toString();
         final docRef = collRef.doc(docId);
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
