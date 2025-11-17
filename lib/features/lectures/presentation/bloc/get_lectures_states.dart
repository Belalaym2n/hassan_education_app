import '../../../dashboard/addLecture/data/models/lecture_model.dart';

abstract class GetLecturesState {}

class GetLecturesInitial extends GetLecturesState {}

class GetLecturesLoading extends GetLecturesState {}

class GetLecturesLoaded extends GetLecturesState {
  final List<LectureModel> lectures;

  GetLecturesLoaded(this.lectures);
}

class GetLecturesError extends GetLecturesState {
  final String message;

  GetLecturesError(this.message);
}
