// features/lectures/presentation/bloc/addLectureEvents.dart
import 'package:equatable/equatable.dart';
 import '../../../data/models/lecture_model.dart';

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

