// features/lectures/presentation/bloc/addLectureEvents.dart
import 'package:equatable/equatable.dart';
 import '../../data/models/lecture_model.dart';

abstract class AddLectureEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddLecturePressed extends AddLectureEvent {
  final LectureModel lecture;
  AddLecturePressed(this.lecture);

  @override
  List<Object?> get props => [lecture];
}
class ChooseSectionEvent extends AddLectureEvent{
  String sectionName;
  int  index;
  ChooseSectionEvent(this.sectionName,this.index);
}
class AddLectureFormChanged extends AddLectureEvent {
  final String name;
  final String description;
  final String videoUrl;
  final String? stage;

  AddLectureFormChanged({
    required this.name,
    required this.description,
    required this.videoUrl,
    required this.stage,

  });

  @override
  List<Object?> get props => [name, description, videoUrl, stage,
    ];
}
