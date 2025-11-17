// features/lectures/data/data_sources/addLectureDSImp.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../config/configeration/app_configeration.dart';
import '../../../../../../core/firebase/firebase_manager.dart';
import '../../../../../../core/handleErrors/exaption_handler.dart';
import '../../../../../../core/handleErrors/result_pattern.dart';
import '../../../../home/dash_board_home.dart';
import '../../models/lecture_model.dart';
import 'add_lecture_ds.dart';

class AddLectureDSImp implements AddSingleLectureDS {
  final FirebaseFirestore firestore;

  AddLectureDSImp({required this.firestore});

  @override
  Future<Result> addLecture(LectureModel lecture) async {
    try {
      final docId = DateTime.now().millisecondsSinceEpoch
          .toString(); // أو أي ID تولده
      // final collectionName = AppConfiguration.lectures;

      lecture.id=docId;
      await FirebaseManager.uploadModel<LectureModel>(
        collectionName: "Lectures",
        model: lecture,
        docId: docId,
        toJson: (e) => e.toJson(),
        fromJson: (json) => LectureModel.fromJson(json)
      );
      return Result.success("Playlist saved successfully");
    } catch (e) {
      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }
}
