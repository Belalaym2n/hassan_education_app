import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/firebase/firebase_manager.dart';
import '../../../../../core/handleErrors/exaption_handler.dart';
import '../../../../../core/handleErrors/result_pattern.dart';
import '../../../../dashboard/addLecture/data/models/lecture_model.dart';
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
}
