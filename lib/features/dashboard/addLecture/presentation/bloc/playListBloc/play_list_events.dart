// features/playlist/presentation/bloc/playlist_events.dart
import 'package:amr_rezk_education/features/lectures/data/models/play_list_model.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/lecture_model.dart';
import '../lectureBloc/add_lecture_events.dart';

abstract class PlaylistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChooseStageEvent extends PlaylistEvent {
  String stageName;
  int index;

  ChooseStageEvent(this.stageName, this.index);
}



class LoadLocalLecturesEvent extends PlaylistEvent {}

class AddLocalLectureEvent extends PlaylistEvent {
  final LectureModel lecture;

  AddLocalLectureEvent(this.lecture);

  @override
  List<Object?> get props => [lecture];
}

class RemoveLocalLectureEvent extends PlaylistEvent {
  final String id;

  RemoveLocalLectureEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UploadLecturesEvent extends PlaylistEvent {
   final PlaylistModel playlist ;

  UploadLecturesEvent(this.playlist);

  @override
  List<Object?> get props => [playlist];
}
