import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dashboard/addLecture/data/models/lecture_model.dart';
import '../../domain/use_cases/get_lectures_use_case.dart';
import 'get_lectures_events.dart';
import 'get_lectures_states.dart';

class GetLecturesBloc extends Bloc<GetLecturesEvent, GetLecturesState> {
  final GetLecturesUseCase useCase;

  static List<LectureModel>? cachedLectures;
  static GetLecturesBloc? _instance;

  bool isLoadedBefore = false;

  factory GetLecturesBloc(GetLecturesUseCase useCase) {
    _instance ??= GetLecturesBloc._internal(useCase);
    return _instance!;
  }

  GetLecturesBloc._internal(this.useCase) : super(GetLecturesInitial()) {
    on<LoadLecturesEvent>((event, emit) async {
      if (isLoadedBefore && cachedLectures != null) {
        emit(GetLecturesLoaded(cachedLectures!));
        return;
      }

      emit(GetLecturesLoading());

      final result = await useCase();
      if (result.isSuccess) {
        cachedLectures = result.data!;
        isLoadedBefore = true;
        emit(GetLecturesLoaded(result.data!));
      } else {
        emit(GetLecturesError(result.error ?? "Unknown Error"));
      }
    });
  }

  static void disposeInstance() {
    _instance?.close();
    cachedLectures = null;
    _instance = null;
  }
}
