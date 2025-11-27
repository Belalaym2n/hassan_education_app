import '../../../dashboard/addLecture/data/models/lecture_model.dart';
import '../../data/models/play_list_model.dart';

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


class PlaylistLoading extends GetLecturesState {}
class LectureOnPlaylistLoading extends GetLecturesState {}
class LectureOnPlaylistLoaded extends GetLecturesState {

  final List<LectureModel> lectures;

  LectureOnPlaylistLoaded(this.lectures);
}
class ChangeTapSuccess extends GetLecturesState {
  int index;
  List<PlaylistModel>playLists;
  List<LectureModel>lectures;
  ChangeTapSuccess({required this.index,required this.playLists,required this.lectures});
}

class PlaylistLoaded extends GetLecturesState {
  final List<PlaylistModel> playlists;

  PlaylistLoaded(this.playlists);
}

class PlaylistError extends GetLecturesState {
  final String message;

  PlaylistError(this.message);
}