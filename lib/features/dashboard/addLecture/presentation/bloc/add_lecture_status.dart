// features/lectures/presentation/bloc/addLectureStates.dart
import 'package:equatable/equatable.dart';

abstract class AddLectureState extends Equatable {
  final bool isValid;
  const AddLectureState({this.isValid = false});

  @override
  List<Object?> get props => [isValid];
}

class AddLectureInitial extends AddLectureState {
  const AddLectureInitial() : super(isValid: false);
}
class SectionSelectedState extends AddLectureState {
  final String sectionName;
  final int index;

  SectionSelectedState({
    required this.sectionName,
    required this.index,
  });
}
class AddLectureLoading extends AddLectureState {}

class AddLectureSuccess extends AddLectureState {}

class AddLectureFailure extends AddLectureState {
  final String error;
  const AddLectureFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class AddLectureFormUpdated extends AddLectureState {
  const AddLectureFormUpdated(bool isValid) : super(isValid: isValid);
}
