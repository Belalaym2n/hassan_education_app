import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/firebase/firebase_manager.dart';
import '../../../../../core/handleErrors/exaption_handler.dart';
import '../../../../../core/handleErrors/result_pattern.dart';
import '../../../../dashboard/addLecture/data/models/lecture_model.dart';
import '../../models/play_list_model.dart';
import 'get_lect_ds.dart';

class GetLecturesDSImp implements GetLecturesDS {
  final FirebaseFirestore firestore;

  GetLecturesDSImp({required this.firestore});

  @override
  Future<Result> getLectures() async {
    try {
      final snapshot = FirebaseManager.getCollection<LectureModel>(
        collectionName: "Lectures",
        fromJson: (json) => LectureModel.fromJson(json),

        toJson: (model) => model.toJson(),
      );
      final querySnapshot = await snapshot.get();
      final lectures = querySnapshot.docs.map((doc) => doc.data()).toList();

      return Result.success(lectures);
    } catch (e) {
      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }

  @override
  Future<Result> getPlayLists() async {
    try {
      final querySnapshot = await firestore.collection("Playlists").get();

      List<PlaylistModel> playLists = querySnapshot.docs.map((doc) {
        final data = doc.data(); // Map<String, dynamic>

        return PlaylistModel.fromJson({
          ...data,
         });
      }).toList();

      print("PlayLists => ${playLists.length}");

      return Result.success(playLists);

    } catch (e) {
      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }


  @override
  Future<Result> getLecturesOnPlaylist(String playListID) async {
    // TODO: implement getLecturesOnPlaylist

    try {
      final lecturesSnap = await firestore
          .collection("Playlists")
          .doc(playListID)
          .collection("Lectures")
          .get();

      final lectures = lecturesSnap.docs
          .map((doc) => LectureModel.fromJson(doc.data()))
          .toList();

      return Result.success(lectures);
    } catch (e) {
      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }
}
