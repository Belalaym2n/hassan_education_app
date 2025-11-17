// features/playlist/presentation/bloc/playlist_states.dart
import 'package:equatable/equatable.dart';
import '../../../data/models/lecture_model.dart';

abstract class PlaylistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaylistInitial extends PlaylistState {}

class PlaylistLoading extends PlaylistState {
  final List<LectureModel>? lectures;
  PlaylistLoading({this.lectures});

}

class PlaylistLoaded extends PlaylistState {
  final List<LectureModel> lectures;
  final bool canUpload;

  PlaylistLoaded({required this.lectures})
      : canUpload = lectures.isNotEmpty;

  @override
  List<Object?> get props => [lectures, canUpload];
}

class SectionSelectedState extends PlaylistState {
  final String sectionName;
  final int index;

  SectionSelectedState({
    required this.sectionName,
    required this.index,
  });
}
class PlaylistActionSuccess extends PlaylistState {
  final String message;
  PlaylistActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PlaylistFailure extends PlaylistState {
  final String error;
  PlaylistFailure(this.error);

  @override
  List<Object?> get props => [error];
}
