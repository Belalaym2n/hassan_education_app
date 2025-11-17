// features/playlist/presentation/bloc/playlist_bloc.dart
import 'package:amr_rezk_education/features/dashboard/addLecture/presentation/bloc/playListBloc/play_list_events.dart';
import 'package:amr_rezk_education/features/dashboard/addLecture/presentation/bloc/playListBloc/play_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../signUp/presentation/bloc/signUpEvents.dart';
import '../../../data/models/lecture_model.dart';
import '../../../domain/use_cases/add_play_list_use_cases.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final AddLectureUseCase addLectureUseCase;
  final GetLocalLecturesUseCase getLocalLecturesUseCase;
  final RemoveLocalLectureUseCase removeLocalLectureUseCase;
  final UploadLecturesUseCase uploadLecturesUseCase;
  String currentStage = 'المرحلة الدراسية';
  int index = -1;
List<LectureModel>lectures=[];
  PlaylistBloc({
    required this.addLectureUseCase,
    required this.getLocalLecturesUseCase,
    required this.removeLocalLectureUseCase,
    required this.uploadLecturesUseCase,
  }) : super(PlaylistInitial()) {
    on<ChooseStageEvent>(_chooseSection);

    on<AddLocalLectureEvent>(_onAddLocal);

    on<LoadLocalLecturesEvent>(_onLoadLocal);
    on<RemoveLocalLectureEvent>(_onRemoveLocal);
    on<UploadLecturesEvent>(_onUpload);
  }



  void _chooseSection(ChooseStageEvent event, Emitter<PlaylistState> emit) {
    currentStage = event.stageName;
    index = event.index;
    emit(SectionSelectedState(sectionName: currentStage, index: index));
  }

  Future<void> _onAddLocal(
    AddLocalLectureEvent event,
    Emitter<PlaylistState> emit,
  ) async {
    final res = await addLectureUseCase.call(event.lecture);
    if (res.isSuccess) {
      final r = await getLocalLecturesUseCase.call();
      if (r.isSuccess) {
        final list = (r.data as List).cast<LectureModel>();
        lectures=list;
        emit(PlaylistLoaded(lectures: list));
        emit(PlaylistActionSuccess("Lecture saved locally"));
      } else {
        emit(PlaylistFailure(r.error.toString()));
      }
    } else {
      emit(PlaylistFailure(res.error.toString()));
    }


  }
  Future<void> _onLoadLocal(
      LoadLocalLecturesEvent event,
      Emitter<PlaylistState> emit,
      ) async {
    emit(PlaylistLoading());
    final res = await getLocalLecturesUseCase.call();
    if (res.isSuccess) {
      final list = (res.data as List).cast<LectureModel>();
      lectures=list;
      emit(PlaylistLoaded(lectures: list));
    } else {
      emit(PlaylistFailure(res.error.toString()));
    }
  }


  Future<void> _onRemoveLocal(
    RemoveLocalLectureEvent event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(PlaylistLoading());
    final res = await removeLocalLectureUseCase.call(event.id);
    if (res.isSuccess) {
      final r = await getLocalLecturesUseCase.call();
      if (r.isSuccess) {
        final list = (r.data as List).cast<LectureModel>();
        lectures=list;
        emit(PlaylistLoaded(lectures: list));
       } else {
        emit(PlaylistFailure(r.error.toString()));
      }
    } else {
      emit(PlaylistFailure(res.error.toString()));
    }
  }

  Future<void> _onUpload(
    UploadLecturesEvent event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(PlaylistLoading(lectures: lectures));
    final r = await getLocalLecturesUseCase.call();
    if (!r.isSuccess) {
      emit(PlaylistFailure(r.error.toString()));
      return;
    }
    final list = (r.data as List).cast<LectureModel>();
    if (list.isEmpty) {
      emit(PlaylistFailure("No lectures to upload"));
      return;
    }

    final res = await uploadLecturesUseCase.call(list, event.playlistId);
    if (res.isSuccess) {
      // after upload, local cleared inside repo
      emit(PlaylistLoaded(lectures: []));
      emit(PlaylistActionSuccess("Uploaded lectures successfully"));
    } else {
      emit(PlaylistFailure(res.error.toString()));
    }
  }
}
