// features/lectures/presentation/bloc/addLectureBloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/add_lecture_use_case.dart';
import 'add_lecture_events.dart';
import 'add_lecture_status.dart';

class AddLectureBloc extends Bloc<AddLectureEvent, AddLectureState> {
  final AddLectureUseCase addLectureUseCase;

  String currentName = '';
  String currentDesc = '';
  String currentUrl = '';
  String currentStage = 'المرحلة الدراسية';
  bool isPlayList = false;
  int index = -1;
  String? playlistCode;

  AddLectureBloc({required this.addLectureUseCase})
    : super(const AddLectureInitial()) {
    on<AddLectureFormChanged>(_onFormChanged);
    on<AddLecturePressed>(_onAddLecturePressed);

    on<ChooseSectionEvent>(_chooseSection);
  }

  void _chooseSection(ChooseSectionEvent event, Emitter<AddLectureState> emit) {
    currentStage = event.sectionName;
    index = event.index;
    emit(SectionSelectedState(sectionName: currentStage, index: index));

    final isValid = _validateForm();
    emit(AddLectureFormUpdated(isValid));
  }

  void _onFormChanged(
    AddLectureFormChanged event,
    Emitter<AddLectureState> emit,
  ) {
    currentName = event.name;
    currentDesc = event.description;
    currentUrl = event.videoUrl;
    currentStage = event.stage!;

    final isValid = _validateForm();
    emit(AddLectureFormUpdated(isValid));
  }

  Future<void> _onAddLecturePressed(
    AddLecturePressed event,
    Emitter<AddLectureState> emit,
  ) async {
    emit(AddLectureLoading());
    final result = await addLectureUseCase.call(lecture: event.lecture);

    if (result.isSuccess) {
      emit(AddLectureSuccess());
    } else {
      emit(AddLectureFailure(result.error.toString()));
    }

    // re-evaluate form validity
    final isValid = _validateForm();
    emit(AddLectureFormUpdated(isValid));
  }

  bool _validateForm() {
    return currentName.trim().isNotEmpty &&
        currentUrl.trim().isNotEmpty &&
        (isPlayList ||
            (currentStage != 'المرحلة الدراسية' && currentStage.isNotEmpty));
  }
}
