// features/lectures/presentation/bloc/addLectureBloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/add_lecture_use_case.dart';
import 'add_lecture_events.dart';
import 'add_lecture_status.dart';

class AddLectureBloc extends Bloc<AddLectureEvent, AddLectureState> {
  final AddLectureUseCase addLectureUseCase;

  String currentStage = 'المرحلة الدراسية';
  bool isPlayList = false;
  int index = -1;
  String? playlistCode;

  AddLectureBloc({required this.addLectureUseCase})
    : super(const AddLectureInitial()) {
    on<AddLecturePressed>(_onAddLecturePressed);

    on<ChooseSectionEvent>(_chooseSection);
  }

  void _chooseSection(ChooseSectionEvent event, Emitter<AddLectureState> emit) {
    currentStage = event.sectionName;
    index = event.index;
    emit(SectionSelectedState(sectionName: currentStage, index: index));
  }

  Future<void> _onAddLecturePressed(
    AddLecturePressed event,
    Emitter<AddLectureState> emit,
  ) async {
    emit(AddLectureLoading());
    final result = await addLectureUseCase.call(lecture: event.lecture);

    if (result.isSuccess)  {
     return emit(AddLectureSuccess());
    } else {
      return emit(AddLectureFailure(result.error.toString()));
    }
  }
}
